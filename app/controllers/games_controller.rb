require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split(' ')
    url = 'https://wagon-dictionary.herokuapp.com/'
    message = open(url).read
    word = JSON.parse(message)
    puts "#{word['message']}"

    if (@word.chars - @letters).empty? == false
      @result = "Sorry but #{@word} can't be built out of #{@letters}."
    elsif @word == ''
      @result = "Sorry but #{@word} does not seem to be a valid English word..."
    else
      @result = "Congratulations! #{@word} is a valid English word!"
    end
  end
end
