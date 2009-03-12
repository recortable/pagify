# == Schema Information
#
# Table name: revisions
#
#  id         :integer(11)     not null, primary key
#  page_id    :integer(11)     
#  mime       :string(255)     
#  data       :text            
#  created_at :datetime        
#  updated_at :datetime        
#

class Revision < ActiveRecord::Base
  belongs_to :page
end
