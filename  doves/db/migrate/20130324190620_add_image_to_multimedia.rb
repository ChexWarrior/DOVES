class AddImageToMultimedia < ActiveRecord::Migration
  def change
    add_column :multimedia, :image, :string

  end
end
