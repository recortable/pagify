class InitialStructure < ActiveRecord::Migration
  def self.up

    create_table "attachments", :force => true do |t|
      t.string   "content_type"
      t.string   "filename"
      t.integer  "size"
      t.string   "label"
      t.string   "description"
      t.integer  "parent_id"
      t.string   "thumbnail"
      t.integer  "width"
      t.integer  "height"
      t.integer  "page_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "metas", :force => true do |t|
      t.integer "page_id"
      t.string  "name"
      t.string  "value"
    end

    create_table "pages", :force => true do |t|
      t.integer  "parent_id"
      t.string   "title",                    :default => "", :null => false
      t.integer  "position"
      t.integer  "depth",      :limit => 8
      t.string   "state",      :limit => 12
      t.string   "mime",       :limit => 12
      t.text     "content"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "revisions", :force => true do |t|
      t.integer  "page_id"
      t.string   "mime"
      t.text     "data"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

  end

  def self.down
    drop_table "attachments"
    drop_table "metas"
    drop_table "pages"
    drop_table "revisions"
  end
end
