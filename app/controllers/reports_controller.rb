class ReportsController < ApplicationController
  def show
    @report = Report.find(params[:id])
  end

  def new
    redirect_to dashboard_path(modal: "open")
  end

  def create
    @report = Report.new(report_params)

    if @report.save
      redirect_to dashboard_path, notice: "Report was successfully created."
    else
      render_dashboard_with_errors
    end
  end

  def update
    @report = Report.find(params[:id])

    if @report.update(report_params)
      field = report_params.keys.first
      render json: {
        field: field,
        raw: @report.public_send(field),
        display: helpers.editable_display(@report, field)
      }
    else
      render json: { errors: @report.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def report_params
    params.require(:report).permit(
      :playerName, :position, :grade, :team, :comments,
      :height, :weight, :age, :strengths, :weaknesses
    )
  end

  def render_dashboard_with_errors
    load_dashboard_for_modal
    @open_modal = true
    render "dashboard/index", status: :unprocessable_entity
  end

  def load_dashboard_for_modal
    @sort_column = params[:sort].to_s
    @sort_column = Report::SORTABLE_COLUMNS.include?(@sort_column) ? @sort_column : DashboardController::DEFAULT_SORT_COLUMN

    direction = params[:direction].to_s.downcase
    @sort_direction = %w[asc desc].include?(direction) ? direction : "desc"

    @reports = Report.sorted_by(@sort_column, @sort_direction)
  end
end
