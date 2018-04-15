class HomeController < ApplicationController
    def index
        @sitters = User.where(is_sitter: true).order(sitter_rank: :desc)
    end
end