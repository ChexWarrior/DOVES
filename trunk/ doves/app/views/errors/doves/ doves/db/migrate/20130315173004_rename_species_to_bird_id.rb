class RenameSpeciesToBirdId < ActiveRecord::Migration
  def up
	rename_column(:submissions, :species, :bird_id)
  end
end
