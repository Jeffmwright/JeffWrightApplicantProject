class DashboardController < ApplicationController
  DEFAULT_SORT_COLUMN = "created_at"
  DEFAULT_SORT_DIRECTION = "desc"

  def index
    @sort_column = sort_column_param
    @sort_direction = sort_direction_param
    @reports = Report.sorted_by(@sort_column, @sort_direction)
    @report = Report.new
    @open_modal = params[:modal] == "open"
  end

  private

  def sort_column_param
    column = params[:sort].to_s
    Report::SORTABLE_COLUMNS.include?(column) ? column : DEFAULT_SORT_COLUMN
  end

  def sort_direction_param
    direction = params[:direction].to_s.downcase
    %w[asc desc].include?(direction) ? direction : default_direction_for(sort_column_param)
  end

  def default_direction_for(column)
    column == DEFAULT_SORT_COLUMN ? DEFAULT_SORT_DIRECTION : "asc"
  end
end
