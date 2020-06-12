class LandingPageController < ApplicationController
  def index
    @offers = Offer.last(6)
  end
end
