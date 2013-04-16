# encoding: utf-8
class HtreesController < ApplicationController
  layout "application"
  respond_to :html, :json
  #@@flare = File.read(Dir.getwd + '/app/assets/javascripts/flare.json')
  #@@db = File.read(Dir.getwd + '/app/assets/javascripts/data.json')

  def index
=begin
	  @tree_arr = []
    @htrees = Htree.find(:all)#, :conditions=> ["parent_id is null"])
@htrees.each do |h|
  tree_hash = {}
  tree_hash[:name] = h.name
  tree_hash[:is_expanded] = h.is_expanded
  @tree_arr << tree_hash
end

    respond_with @tree_arr do |format|
      format.html
      format.json {render json: @tree_hash}
    end
=end
  end
  
  def fetch_flare
    htree = Htree.find(:first, :conditions=> ["parent_id is null"])
    htree_hash = make_tree_hash
    data = htree_hash.to_json
    render :json => data.html_safe.to_json
  end

  def udpate_state
    htree = Htree.where(:id => params[:id].to_i).first
    htree.update_attributes(:is_expanded => !htree.is_expanded) if htree
    render :text => 'success'
  end
  
  def create_child
    if params[:id] and params[:id] != ""
      hparent = Htree.where(:id => params[:id].to_i).first
      hchild =Htree.create(:name => "child", :is_expanded => false, :parent_id => hparent.id)
      ## CHECK if parent has only one child, that means child has been created for first time so parent record it should be visible.
      if hparent and hparent.childrens.size == 1
        hparent.update_attributes(:is_expanded => true)
      end
      htree_hash = make_tree_hash
      data = htree_hash.to_json
      render :json => data.html_safe.to_json
    end
  end
  
  def make_tree_hash
    htree = Htree.find(:first, :conditions=> ["parent_id is null"])
    htree_hash = {}
    htree_hash[:name] = htree.name
    htree_hash[:id] = htree.id
    htree_hash[:is_expanded] = htree.is_expanded
    htree_hash[:children] = htree.find_childrens_arrhash(htree.id)
    return htree_hash
  end
  
end
