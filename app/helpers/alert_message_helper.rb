module AlertMessageHelper
  def show_messages
    return "" if resource.errors.empty?
    messages = resource.errors.full_messages
    html = <<-HTML
      <div class="alert alert-danger">
      <button type="button" class="close">&times;</button>
        #{messages.first}
      </div>
    HTML
    html.html_safe
  end
end
