class User < ActiveRecord::Base
    has_many :dogs
    has_many :sittings
    has_many :review, :through => :sittings
end