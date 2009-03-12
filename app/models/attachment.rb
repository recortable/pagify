# == Schema Information
#
# Table name: attachments
#
#  id           :integer(11)     not null, primary key
#  content_type :string(255)     
#  filename     :string(255)     
#  size         :integer(11)     
#  tags         :string(255)     
#  description  :string(255)     
#  parent_id    :integer(11)     
#  thumbnail    :string(255)     
#  width        :integer(11)     
#  height       :integer(11)     
#  created_at   :datetime        
#  updated_at   :datetime        
#  page_id      :integer(11)     
#

class Attachment < ActiveRecord::Base
  has_attachment :storage => :file_system, :thumbnails => { :thumb => 'x150' }, :max_size => 4.megabytes,
    :path_prefix => APP_CONFIG['files_path']
  validates_as_attachment
  belongs_to :page
  
  def image?
    content_type == 'image/gif' || content_type == 'image/jpeg' || content_type == 'image/png'
  end
  
  def pdf?
    content_type == 'application/pdf'
  end
end


