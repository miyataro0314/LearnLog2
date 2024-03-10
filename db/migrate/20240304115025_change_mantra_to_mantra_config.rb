class ChangeMantraToMantraConfig < ActiveRecord::Migration[7.1]
  def up
    rename_column :profiles, :mantra, :mantra_config
    change_column :profiles, :mantra_config, :integer
  end

  def down
    change_column :profiles, :mantra_config, :text
    rename_column :profiles, :mantra_config, :mantra
  end
end
