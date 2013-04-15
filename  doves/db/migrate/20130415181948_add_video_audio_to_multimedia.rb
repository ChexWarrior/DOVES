class AddVideoAudioToMultimedia < ActiveRecord::Migration
  def change
    add_column :multimedia, :video, :string

    add_column :multimedia, :audio, :string

  end
end
