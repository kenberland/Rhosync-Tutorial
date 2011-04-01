class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.string :caption
      t.binary :image

      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end
end
