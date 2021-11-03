class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.string :session_id
      t.string :query
      t.timestamps
    end
  end
end
