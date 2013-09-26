class RenameColumnToVehicles < ActiveRecord::Migration
  def change
    rename_column :vehicles, :type, :v_type
  end
end
