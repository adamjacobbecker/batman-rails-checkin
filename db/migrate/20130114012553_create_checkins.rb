class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.text :body

      t.timestamps
    end
  end
end
