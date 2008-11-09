class CreateAds < ActiveRecord::Migration
  def self.up
    create_table :ads do |t|
      t.string :name
      t.string :phone
      t.string :company
      t.string :business_item
      t.string :copy1
      t.string :copy2
      t.string :phone2
      t.string :fax
      t.string :www
      t.string :hp
      t.string :kind
      t.string :size
      t.string :template
      t.string :geo_code
      t.string :country
      t.string :city
      t.string :area
      t.string :category1
      t.string :category2
      t.string :category3
      
      

      t.timestamps
    end
  end

  def self.down
    drop_table :ads
  end
end
