module DashboardHelper
  def sortable_column_header(column, label)
    direction = next_sort_direction(column)
    classes = [ "sort-link" ]
    classes << "sort-link--active" if @sort_column == column

    link_to dashboard_path(sort: column, direction: direction), class: classes.join(" ") do
      parts = [ label ]
      parts << sort_indicator(column) if @sort_column == column
      safe_join(parts)
    end
  end

  private

  def next_sort_direction(column)
    return "asc" unless @sort_column == column

    @sort_direction == "asc" ? "desc" : "asc"
  end

  def sort_indicator(column)
    triangle = @sort_direction == "asc" ? "▲" : "▼"
    tag.span(triangle, class: "sort-indicator", aria: { hidden: true })
  end
end
