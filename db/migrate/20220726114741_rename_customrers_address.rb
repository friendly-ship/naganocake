class RenameCustomrersAddress < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :adress, :address
  end
end
