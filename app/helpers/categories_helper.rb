module CategoriesHelper

  def all_categories_colors
    Hash[ Category.all.map { |c| [ c.name, c.color ] } ]
  end

end
