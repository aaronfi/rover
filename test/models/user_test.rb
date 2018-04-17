require 'test_helper'

class UserTest < ActiveSupport::TestCase
    test "sitter score calculation" do
        sitter = users(:sitter1)

        sitter.name = "abcdefghijklmnopqrstuvwxyz"
        sitter.update_sitter_score()
        assert_equal sitter.sitter_score, 5.0

        sitter.name = "aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ"
        sitter.update_sitter_score()
        assert_equal sitter.sitter_score, 5.0

        sitter.name = "a"
        sitter.update_sitter_score()
        assert_equal sitter.sitter_score, 0.19230769230769232

        sitter.name = ".,./1.2-4021_____"
        sitter.update_sitter_score()
        assert_equal sitter.sitter_score, 0.0

        sitter.name = ""
        sitter.update_sitter_score()
        assert_equal sitter.sitter_score, 0.0

        sitter.name = ".,./1.2-4021__aA___________"
        sitter.update_sitter_score()
        assert_equal sitter.sitter_score, 0.19230769230769232
    end

    test "ongoing calculation of all scores over 12 sittings" do
        owner = users(:owner1)
        sitter = users(:sitter1)

        assert owner.is_owner

        assert sitter.is_sitter
        assert_equal sitter.sitter_score, 0.0
        assert_equal sitter.ratings_score, 0.0
        assert_equal sitter.sitter_rank, 0.0
        assert_equal sitter.review_ratings_sum, 0.0
        assert_equal sitter.num_sitter_stays, 0

        sitter.update_sitter_score_and_save()
        assert_equal sitter.sitter_score, 0.9615384615384616  # for the name "sitter1"

        # TODO(aaronfi) in progress... 
    end
end

# TODO(aaronfi)
#
# The Overall Sitter Rank and its score components must be kept up to date.
# That means whenever a relevant event happens, that could affect the Overall Sitter Rank, we need to recompute it.
# Think about what can make the Overall Sitter Rank change.

