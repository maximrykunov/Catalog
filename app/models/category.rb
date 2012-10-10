class Category < ActiveRecord::Base

  acts_as_nested_set

  attr_accessible :name, :parent_id

  def self.only_parents_for(parent_id = nil)
    scoped.where(parent_id.nil? ? 'parent_id IS NULL' : ['parent_id = ?', parent_id]).order('depth asc, name asc')
  end
end
