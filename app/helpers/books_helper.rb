module BooksHelper
  def load_categories
    @categories = Category.all.map{|c| [c.name, c.id]}
  end

  def all_category
    Category.all
  end
end
