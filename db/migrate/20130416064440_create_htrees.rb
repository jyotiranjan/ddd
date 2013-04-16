class CreateHtrees < ActiveRecord::Migration
  def change
    create_table :htrees do |t|
      t.string :name, :limit => 255
      t.boolean :is_expanded
      t.integer :parent_id
      t.timestamps
    end
    h1= Htree.create(:name => "Soft Eng", :is_expanded => true, :parent_id => nil)
    
    h2 =Htree.create(:name => "Developer", :is_expanded => true, :parent_id => h1.id)
    h3 =Htree.create(:name => "Tester", :is_expanded => false, :parent_id => h1.id)
    h4 =Htree.create(:name => "GUI Designer", :is_expanded => false, :parent_id => h1.id)
    
    h6 =Htree.create(:name => "C", :is_expanded => false, :parent_id => h2.id)
    h7 =Htree.create(:name => "C++", :is_expanded => false, :parent_id => h2.id)
    h8 =Htree.create(:name => "Java", :is_expanded => false, :parent_id => h2.id)
    h9 =Htree.create(:name => "Ruby", :is_expanded => false, :parent_id => h2.id)
    
    h10 =Htree.create(:name => "QTI", :is_expanded => false, :parent_id => h3.id)
    h11 =Htree.create(:name => "Manual", :is_expanded => false, :parent_id => h3.id)

    h10 =Htree.create(:name => "JS", :is_expanded => false, :parent_id => h4.id)
    h11 =Htree.create(:name => "CSS", :is_expanded => false, :parent_id => h4.id)
    h11 =Htree.create(:name => "Photoshop", :is_expanded => false, :parent_id => h4.id)
  end
end
