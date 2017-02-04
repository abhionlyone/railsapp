class AddUidToDevise < ActiveRecord::Migration
  def change
  	change_table(:users) do |t| 
      t.string   :uid
    end
  end
end
