class Dog < ActiveRecord::Base
    belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
    has_and_belongs_to_many :sittings
end