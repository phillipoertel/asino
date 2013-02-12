module ItemsHelper
  def item_category_select(form, item)
    js = "$.ajax({
      type: 'GET',
      url: '#{add_category_item_path(item)}',
      data: $('#edit_item_#{item.id}').serialize(this.form) })"
    form.select(
      :category_id, 
      options_string(item.category).html_safe, 
      {:include_blank => true}, 
      {:onchange => js}
    )
  end
  
  def options_string(current_category)
    Category.top_level.map do |category|
      if category.has_subcategories?
        sub_options = option_tag(category, current_category, true)
        sub_options << category.categories.sort_by(&:name).map { |c| option_tag(c, current_category) }.join("\n").html_safe
        content_tag("optgroup", sub_options.html_safe, {:label => category.name})
      else
        option_tag(category, current_category)
      end
    end.join("\n")
  end
  
  def option_tag(category, current_category, common = false)
    attrs = {:value => category.id}
    attrs[:selected] = 'selected' if (category.id == current_category.id)
    name = category.name.dup
    name << " (Allgemein)" if common
    content_tag('option', name, attrs).html_safe
  end
end