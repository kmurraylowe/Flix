class ReviewsController < ApplicationController
  before_action :require_signin
  before_action :set_movie

def index
    #@movie = Movie.find(params[:movie_id])
    @reviews = @movie.reviews
end

def new
    #@movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.new
end

def create
    #@movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to movie_reviews_path(@movie),
                    notice: "Thanks for your review!"
    else
      render :new
    end
  end
 
  def destroy
    
    #@movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.find(params[:id])
    @review.destroy
    redirect_to movie_reviews_url, :notice => "Review Successfully Deleted!"
  end

  def edit
    #@movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.find(params[:id])
  end


  def update
    @review = @movie.reviews.find(params[:id])
    if @review.update(review_params)
    redirect_to movie_reviews_path, notice: "Review successfully updated"
    else
      render :edit
    end
  end

private

def review_params
    params.require(:review).permit(:comment, :stars, :edit)
end

def set_movie
  @movie = Movie.find_by!(slug: params[:movie_id])
end
end