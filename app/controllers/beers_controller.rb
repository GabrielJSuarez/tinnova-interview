class BeersController < ApplicationController
  before_action :authenticate!
  before_action :fav_beers_list, only: [:get_favorites]

  def index
    @user = User.find_by(id: @current_user.id)
    save_fetch_beers
    render_beers = Beer.all.where(user_id: @user.id).order(favorite: :desc).map do |beer|
      {
        "id": beer["id"],
        "name": beer["name"],
        "tagline": beer["tagline"],
        "description": beer["description"],
        "abv": beer["abv"],
        "favorite": beer["favorite"],
        "seen_at": beer["seen_at"]
      }
    end
    render json: render_beers.uniq { |e| e[:name]}, :status => 200
  end

  def get_favorites
    render json: @fav_beers
  end

  def save_favorite
    @beer = Beer.find_by(name: params[:name])
    if Favorite.favorite?(@beer)
      render json: {
        "notice": "Beer is already a favorite"
      }
    else
      @beer.favorite = true
      @beer.save
      render json: {
        "success": "favorite saved!"
      }
    end
  end

  private

  def beer_params
    params.permit(:beer_name, :abv_gt, :page, :name)
  end

  def get_beer_list
    Faraday.get('https://api.punkapi.com/v2/beers') do |req|
      if params.has_key?(:beer_name)
        req.params['beer_name'] = beer_params[:beer_name]
      elsif params.has_key?(:abv_gt)
        req.params['abv_gt'] = beer_params[:abv_gt].to_i
      elsif params.has_key?(:page)
        req.params['page'] = beer_params[:page].to_i
      end
    end
  end

  def beer_info(body)
    body.map do |beer|
      {
        "id": beer["id"],
        "name": beer["name"],
        "description": beer["description"],
        "tagline": beer["tagline"],
        "abv": beer["abv"]
      }
    end
  end

  def save_fetch_beers
    response = get_beer_list
    body = JSON.parse(response.body)
    beers = beer_info(body)

    beers.each do |beer|
      @user = User.find_by(id: @current_user.id)
      check_beer = Beer.where(user_id: @user.id).find_by(name: beer[:name])
      next if check_beer && check_beer.user.id == @user.id

      @beer = @user.beers.build(name: beer[:name],
                                description: beer[:description],
                                tagline: beer[:tagline],
                                abv: beer[:abv],
                                seen_at: DateTime.now)

      next unless @beer.save
    end
  end

  def fav_beers_list
    @fav_beers = []
    @user = User.find_by(id: @current_user.id)
    @favorite_beers = @user.beers.where(favorite: true).each do |fav|
        @fav_beers << fav
    end
    @fav_beers
  end
end
