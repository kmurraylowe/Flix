class GenresController < ApplicationController
    before_action :require_signin
    before_action :require_admin, except: :show
    before_action :set_genre, only: [:edit, :show, :update, :destroy]
  
    def index
      @genres = Genre.all
      @genre = Genre.new
    end
  
    def create
      @genre = Genre.new(genre_params)
      @genres = Genre.all
      if @genre.save
        redirect_to genres_url, notice: "Genre Successfully Created!"
      else
        render :index
      end
    end
  
    def destroy
      @genre.destroy
      redirect_to genres_url, alert: "Genre Removed!"
    end
  
    def edit
    end
  
    def show
        
    end
  
    def update
      if @genre.update(genre_params)
        redirect_to genres_url, notice: "Genre Successfully Updated!"
      else
        render :edit
      end
    end
  
  private
    def genre_params
      params.require(:genre).permit(:name)
    end
  
    def set_genre
        @genre = Genre.find_by!(slug: params[:id])
      end
  
  end