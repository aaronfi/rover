class Review < ActiveRecord::Base
    belongs_to :sitting

    after_create do
        sitter = User.find( Sitting.find(self.sitting_id).sitter_id )
        sitter.review_ratings_sum += self.review_rating
        sitter.update_ratings_score()
        sitter.update_sitter_rank()
        sitter.save!
    end

    before_update do
        # TODO(aaronfi) disallow names being updated after created.  Or should I allow them to be changed,
        # just update their score?  Probably the latter.
    end
end