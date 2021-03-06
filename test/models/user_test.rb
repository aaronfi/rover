require 'test_helper'
require 'pp'

class UserTest < ActiveSupport::TestCase
    test "sitter score calculation" do
        sitter = users(:sitter1)

        sitter.name = "abcdefghijklmnopqrstuvwxyz"
        sitter.update_sitter_score()
        assert_equal 5.0, sitter.sitter_score

        sitter.name = "aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ"
        sitter.update_sitter_score()
        assert_equal 5.0, sitter.sitter_score

        sitter.name = "a"
        sitter.update_sitter_score()
        assert_equal 0.19230769230769232, sitter.sitter_score

        sitter.name = ".,./1.2-4021_____"
        sitter.update_sitter_score()
        assert_equal 0.0, sitter.sitter_score

        sitter.name = ""
        sitter.update_sitter_score()
        assert_equal 0.0, sitter.sitter_score

        sitter.name = ".,./1.2-4021__aA___________"
        sitter.update_sitter_score()
        assert_equal 0.19230769230769232, sitter.sitter_score
    end

    test "ongoing calculation of all scores over 12 sittings" do
        owner = users(:owner1)
        sitter = users(:sitter1)

        assert owner.is_owner
        assert sitter.is_sitter
        assert_equal 0.0, sitter.sitter_score
        assert_equal 0.0, sitter.ratings_score
        assert_equal 0.0, sitter.sitter_rank
        assert_equal 0, sitter.review_ratings_sum
        assert_equal 0, sitter.num_sitter_stays

        # verify initial scores, prior to any sitting
        sitter.name = "abcdefghijklm"
        sitter.update_sitter_score()
        sitter.update_sitter_rank()
        sitter.save!
        assert_equal 2.5, sitter.sitter_score
        assert_equal 2.5, sitter.sitter_rank

        # verify scores after each of 12 sittings
        1.upto(12) do |i|
            dog1 = dogs(:dog1)
            sitting1 = Sitting.create(sitter_id: sitter.id, owner_id: owner.id, start_date: "41225", end_date: "41262", dog_ids: [dog1.id])
            Review.create(review_text: "some review", review_rating: 5, sitting_id: sitting1.id)

            sitter = User.find(sitter.id)  # must reload manually, otherwise fixture data remains stale
            sitter.update_ratings_score()
            sitter.update_sitter_rank()
            sitter.save!

            assert_equal 5.0, sitter.ratings_score
            assert_equal (i <= 10 ? (2.5 + i*0.25) : 5.0), sitter.sitter_rank
            assert_equal 5*i, sitter.review_ratings_sum
            assert_equal i, sitter.num_sitter_stays
        end
    end
end

# TODO(aaronfi)
#
# The Overall Sitter Rank and its score components must be kept up to date.
# That means whenever a relevant event happens, that could affect the Overall Sitter Rank, we need to recompute it.
# Think about what can make the Overall Sitter Rank change.

