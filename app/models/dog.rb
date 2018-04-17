# == Schema Information
#
# Table name: dogs
#
#  id         :integer          not null, primary key
#  name       :string
#  owner_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_dogs_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_95be3172cf  (owner_id => users.id)
#

class Dog < ActiveRecord::Base
    belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
    has_and_belongs_to_many :sittings
end
