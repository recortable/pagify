class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.integer  "parent_id"
      t.string   "title",      :null => false
      t.integer  "position"
      t.integer  "depth",      :limit => 5
      t.string   "state",      :limit => 12
      t.string   "mime",       :limit => 12
      t.text     "content"
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
