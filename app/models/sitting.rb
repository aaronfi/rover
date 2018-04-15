class Sitting < ActiveRecord::Base
    belongs_to :sitter, :class_name => "User", :foreign_key => "sitter_id"
    belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"

    # TODO(aaron) figure out many-to-many relationship and how to populate the sittings_dogs table with seed data
end