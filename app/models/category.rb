class Category < ActiveRecord::Base

  acts_as_nested_set

  attr_accessible :name, :parent_id

  def self.only_parents_for(parent_id = nil)
    scoped.where(parent_id.nil? ? 'parent_id IS NULL' : ['parent_id = ?', parent_id]).order('depth asc, name asc')
  end

  def self.whole_tree
    cat_array = []
    Category.roots.each do |mcat|
      Category.each_with_level(mcat.self_and_descendants) do |cat, level|
        cat_array << ["#{'-' * cat.level} #{cat.name}", cat.id, cat.leaf? ? {} : {disabled: true}]
      end
    end
    cat_array
  end

  def self.tree
    cat_array = []
    position = 0
    Category.roots.each do |mcat|
      Category.each_with_level(mcat.self_and_descendants) do |cat, level|
        cat_array << {id: cat.id, name: "#{'-' * cat.level} #{cat.name}", position: position+=1, enabled: cat.leaf? ? true : false}
      end
    end
    cat_array
  end
end
