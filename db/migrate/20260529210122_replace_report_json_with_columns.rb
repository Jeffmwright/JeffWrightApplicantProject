class ReplaceReportJsonWithColumns < ActiveRecord::Migration[8.0]
  class MigrationReport < ActiveRecord::Base
    self.table_name = "reports"
  end

  def up
    add_column :reports, :height, :string
    add_column :reports, :weight, :integer
    add_column :reports, :age, :integer
    add_column :reports, :strengths, :text
    add_column :reports, :weaknesses, :text

    migrate_json_data

    remove_column :reports, :playerInformation
    remove_column :reports, :playerEvaluations
  end

  def down
    add_column :reports, :playerInformation, :json
    add_column :reports, :playerEvaluations, :json

    MigrationReport.reset_column_information
    MigrationReport.find_each do |report|
      report.update_columns(
        playerInformation: {
          height: report.height,
          weight: report.weight,
          age: report.age
        },
        playerEvaluations: {
          strengths: report.strengths,
          weaknesses: report.weaknesses
        }
      )
    end

    remove_column :reports, :height
    remove_column :reports, :weight
    remove_column :reports, :age
    remove_column :reports, :strengths
    remove_column :reports, :weaknesses
  end

  private

  def migrate_json_data
    MigrationReport.reset_column_information

    MigrationReport.find_each do |report|
      info = parse_json(report.read_attribute(:playerInformation))
      evals = parse_json(report.read_attribute(:playerEvaluations))

      MigrationReport.where(id: report.id).update_all(
        height: info["height"],
        weight: info["weight"],
        age: info["age"] || 22,
        strengths: strengths_from_evals(evals),
        weaknesses: weaknesses_from_evals(evals)
      )
    end
  end

  def parse_json(value)
    case value
    when Hash then value.transform_keys(&:to_s)
    when String then JSON.parse(value)
    else {}
    end
  rescue JSON::ParserError
    {}
  end

  def strengths_from_evals(evals)
    return "" unless evals.is_a?(Hash) && evals.any?

    evals.map { |key, score| "#{key.to_s.tr('_', ' ').capitalize} (#{score})" }.join(", ")
  end

  def weaknesses_from_evals(_evals)
    "See strengths for trait scores; add detailed weaknesses after migration."
  end
end
