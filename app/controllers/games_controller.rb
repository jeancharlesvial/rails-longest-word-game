require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split(' ')
    response = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    message = JSON.parse(response)
    if (@word.chars - @letters).empty? == false
      @result = "Sorry but #{@word} can't be built out of #{@letters}."
    elsif @word == message['word']
      @result = "Congratulations! #{@word} is a valid English word!"
    else
      @result = "Sorry but #{@word} does not seem to be a valid English word..."
    end
  end
end
