class CreateReports < ActiveRecord::Migration[8.0]
  def change
    create_table :reports do |t|
      t.string :playerName
      t.string :position
      t.integer :grade
      t.string :team
      t.json :playerInformation
      t.json :playerEvaluations
      t.text :comments

      t.timestamps
    end
  end
end
