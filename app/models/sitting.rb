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