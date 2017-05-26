class AddSiteNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :site_name, :string
  end
end
