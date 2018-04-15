class Sitting < ActiveRecord::Base
    belongs_to :sitter, :class_name => "User", :foreign_key => "sitter_id"
    belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
    has_and_belongs_to_many :dogs
end