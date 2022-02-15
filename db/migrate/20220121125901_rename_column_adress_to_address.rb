class RenameColumnAdressToAddress < ActiveRecord::Migration[5.2]
  def change
    rename_column :companies, :adress, :address
  end
end
