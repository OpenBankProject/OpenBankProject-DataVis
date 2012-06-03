class Category < ActiveRecord::Base
  has_many :transactions

  attr_accessible :category_name, :category_type, :parent_category_id

  def parent
  	Category.find_by_id(self.parent_category_id)
  end

end
