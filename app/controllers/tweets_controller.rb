class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def index
    @tweets = Tweet.order(created_at: :desc)
  end

  def show
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.tdate = Time.current

    if @tweet.save
      flash[:notice] = 'Tweet was successfully created.'
      redirect_to @tweet
    else
      flash.now[:alert] = @tweet.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params.except(:tdate))
      flash[:notice] = 'OK'
      redirect_to @tweet
    else
      flash.now[:alert] = @tweet.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @tweet.destroy
    flash[:notice] = 'Tweet was successfully deleted.'
    redirect_to tweets_path
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:message)
  end
end
