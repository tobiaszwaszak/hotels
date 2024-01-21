class HotelsController < ApplicationController
  def index
    results = ::Actions::Hotels::Index.new.call(params)
    render json: results
  end
end
