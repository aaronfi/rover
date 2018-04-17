# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string
#  email              :string
#  phone_number       :string
#  image_url          :string
#  is_owner           :boolean          default(FALSE)
#  is_sitter          :boolean          default(FALSE)
#  sitter_score       :float            default(0.0)
#  ratings_score      :float            default(0.0)
#  sitter_rank        :float            default(0.0)
#  review_ratings_sum :integer          default(0)
#  num_sitter_stays   :integer          default(0)
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  index_users_on_email        (email) UNIQUE
#  index_users_on_sitter_rank  (sitter_rank)
#

class User < ActiveRecord::Base
    has_many :dogs
    has_many :sittings
    has_many :review, :through => :sittings

    SITTER_STAY_COUNT_CUTOFF = 10

    after_create :update_sitter_score_and_save
    # after_update :update_sitter_score_and_save, :if => :name_changed?

    def update_sitter_score
        self.sitter_score = calc_sitter_score()
    end

    def update_sitter_score_and_save
        update_sitter_score
        save!
    end

    def update_ratings_score
        self.ratings_score = calc_ratings_score()
    end

    def update_sitter_rank
        self.sitter_rank = calc_sitter_rank()
    end

    private
    def calc_sitter_score
        # Sitter Score is 5 times the fraction of the English alphabet comprised by
        # the distinct letters in what we've recovered of the sitter's name.

        (5.0 * self.name.downcase.chars.uniq.select { |c| c =~ /[a-z]/ }.length) / 26.0
    end

    def calc_ratings_score
        # Ratings Score is the average of their stay ratings.

        self.review_ratings_sum.to_f / self.num_sitter_stays
    end

    def calc_sitter_rank
        # The Overall Sitter Rank is a weighted average of the Sitter Score and Ratings Score,
        # weighted by the number of stays.  When a sitter has no stays, their Overall Sitter Rank is
        # equal to the Sitter Score.  When a sitter has 10 or more stays, their Overall Sitter Rank
        # is equal to the Ratings Score.

        if self.num_sitter_stays == 0
            return self.sitter_score
        elsif self.num_sitter_stays >= SITTER_STAY_COUNT_CUTOFF
            return self.ratings_score
        else
            weighting1 = ((SITTER_STAY_COUNT_CUTOFF - self.num_sitter_stays) / SITTER_STAY_COUNT_CUTOFF.to_f)
            weighting2 = (self.num_sitter_stays / SITTER_STAY_COUNT_CUTOFF.to_f)

            return weighting1 * self.sitter_score + weighting2 * self.ratings_score
        end
    end
end
