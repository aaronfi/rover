class HomeController < ApplicationController
    def index
        @sitters = User.where(is_sitter: true).all
    end
end