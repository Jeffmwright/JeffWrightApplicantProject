module ReportsHelper
  def editable_field(report, field, type: "text", mono: false, multiline: false, select_options: nil)
    raw_value = report.public_send(field)
    display_html = editable_display(report, field)

    tag.dd(
      class: [ "editable-field", ("mono" if mono) ].compact,
      data: {
        controller: "inline-edit",
        inline_edit_url_value: report_path(report),
        inline_edit_field_value: field,
        inline_edit_type_value: type,
        inline_edit_multiline_value: multiline,
        inline_edit_raw_value: raw_value.to_s,
        inline_edit_options_value: select_options || [],
        action: "click->inline-edit#startEdit"
      }
    ) do
      tag.span(display_html.html_safe, data: { inline_edit_target: "display" })
    end
  end

  def editable_display(report, field)
    value = report.public_send(field)

    case field.to_sym
    when :weight
      "#{value} lbs"
    when :comments
      value.presence || "-"
    when :strengths, :weaknesses
      value.present? ? simple_format(value) : "-"
    else
      value.to_s
    end
  end
end
