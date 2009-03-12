class CreateRevisions < ActiveRecord::Migration
  def self.up
    create_table :revisions do |t|
      t.integer  "page_id"
      t.string   "mime"
      t.text     "data"
      t.timestamps
    end
  end

  def self.down
    drop_table :revisions
  end
end
