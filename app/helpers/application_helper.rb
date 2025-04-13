module ApplicationHelper
  def render_field_error(object, field)
    if object.errors.any?
      object.errors.full_messages_for(field).each do |message|
        concat content_tag(:div, message, class: "-mt-3 mb-4 text-sm text-red-700")
      end
    end
  end
end
