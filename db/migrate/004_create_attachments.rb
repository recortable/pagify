class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string      "content_type"
      t.string      "filename"
      t.integer     "size"
      t.string      "label"
      t.string      "description"
      t.integer     "parent_id"
      t.string      "thumbnail"
      t.integer     "width"
      t.integer     "height"
      t.references  "page"
      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
