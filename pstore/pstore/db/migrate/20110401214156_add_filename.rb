class AddFilename < ActiveRecord::Migration
  def self.up
    add_column(:pictures, :image_uri, :string)
  end

  def self.down
    remove_column(:pictures, :image_uri )
  end
end
