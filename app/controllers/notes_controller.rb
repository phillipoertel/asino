# Notes on items are not really an own model, they are attributes of items
class NotesController < ApplicationController
  
  layout false
  
  before_filter :load_item
  
  def create
   @item.update_attributes(params[:item]) 
  end
  
  def destroy
    @item.update_attribute(:note, '') 
  end
  
  private
  
  def load_item
    @item = Item.find(params[:item_id])
  end
  
end