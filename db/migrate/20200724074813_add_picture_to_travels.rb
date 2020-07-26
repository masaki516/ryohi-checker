class AddPictureToTravels < ActiveRecord::Migration[5.2]
  def change
    add_column :travels, :picture, :string
  end
end
