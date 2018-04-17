# == Schema Information
#
# Table name: sittings
#
#  id         :integer          not null, primary key
#  start_date :string
#  end_date   :string
#  sitter_id  :integer
#  owner_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_sittings_on_owner_id   (owner_id)
#  index_sittings_on_sitter_id  (sitter_id)
#
# Foreign Keys
#
#  fk_rails_b95a4e5005  (sitter_id => users.id)
#  fk_rails_e5d7381707  (owner_id => users.id)
#

class Sitting < ActiveRecord::Base
    belongs_to :sitter, :class_name => "User", :foreign_key => "sitter_id"
    belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
    has_and_belongs_to_many :dogs

    after_create do
        sitter = User.find(self.sitter_id)
        sitter.num_sitter_stays += 1
        sitter.update_ratings_score()
        sitter.update_sitter_rank()
        sitter.save!
    end
end
