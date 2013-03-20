# A category is used to collect and order items
class Category < ActiveRecord::Base
  has_many :items, :order => 'created_at desc'
  has_many :categories, :order => 'name', :dependent => :destroy
  belongs_to :category
  
  attr_accessor :account_id, :sum, :lastmonth_sum, :percent

  after_update :update_transfer_attribute_on_items
  
  def has_subcategories?
    !categories.empty?
  end
  
  def has_parent_category?
    !!category
  end
  
  def self.top_level
    where(:category_id => nil).order('name').includes(:categories)
  end
  
  private
  
    def update_transfer_attribute_on_items
      items.update_all(:transfer => self.transfer)
    end
end
