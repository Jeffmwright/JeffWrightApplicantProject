class Report < ApplicationRecord
  POSITIONS = %w[QB RB WR TE C G T DL LB S CB DB P K].freeze
  SORTABLE_COLUMNS = %w[playerName position grade team created_at].freeze

  scope :sorted_by, ->(column, direction = "asc") {
    column = column.to_s
    direction = direction.to_s.downcase == "desc" ? :desc : :asc

    unless SORTABLE_COLUMNS.include?(column)
      return order(created_at: :desc)
    end

    order(column => direction)
  }

  validates :position, presence: true, inclusion: { in: POSITIONS }
  validates :playerName, presence: true
  validates :grade, numericality: { only_integer: true, in: 0..100 }
  validates :height, presence: true
  validates :weight, numericality: { only_integer: true, greater_than: 0 }
  validates :age, numericality: { only_integer: true, greater_than: 0 }
  validates :strengths, presence: true
  validates :weaknesses, presence: true
end
