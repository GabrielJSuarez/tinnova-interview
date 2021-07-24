class Favorite < ApplicationRecord
  belongs_to :beer

  def self.favorite?(beer)
    Favorite.all.exists?(beer.id)
  end
end
