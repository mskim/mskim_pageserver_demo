class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
      t.integer :ad_id
      t.string :media
      t.date :posting_date
      t.string :page
      t.string :position

      t.timestamps
    end
  end

  def self.down
    drop_table :bookings
  end
end
