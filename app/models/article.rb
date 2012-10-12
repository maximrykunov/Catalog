class Article < ActiveRecord::Base
  belongs_to :category
  attr_accessible :name, :category_id

  def category_name
  	category ? category.name : ''
  end
end
