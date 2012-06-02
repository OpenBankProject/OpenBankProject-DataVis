class Category < ActiveRecord::Base
  attr_accessible :category_name, :category_type, :parent_category_id
end
