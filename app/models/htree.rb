class Htree < ActiveRecord::Base
  attr_accessible :name, :parent_id, :is_expanded
  has_many :childrens, :class_name => "Htree",:foreign_key => "parent_id"
  belongs_to :parent, :class_name => "Htree"
  
  def find_childrens_arrhash(parent_id)
    htrees = Htree.find(:all, :conditions => ["parent_id = ?", parent_id]) 
    child_arr = []
    i = 0
    if htrees and !htrees.empty?
      htrees.each do |h|
        child_arr[i] ||= Hash.new
	child_arr[i][:id] = "#{h.id}"
	child_arr[i][:name] = "#{h.name}"
	child_arr[i][:is_expanded] = "#{h.is_expanded}"
	child_arr[i][:children] = find_childrens_arrhash(h.id)
	i = i + 1
      end
    end
    return child_arr
  end
  
end
