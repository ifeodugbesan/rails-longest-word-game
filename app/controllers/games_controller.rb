require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    grid = ('A'..'Z').to_a
    @letters = Array.new(9) { grid.sample }
  end

  def score
    @words = params[:grid].split(' ')
    @guess = params[:word].upcase.split('')
    @result = @guess.all? do |letter|
      @guess.count(letter) <= @words.count(letter)
    end
    url = "https://wagon-dictionary.herokuapp.com/#{@guess.join}"
    user_serialized = open(url).read
    @real_word = JSON.parse(user_serialized)
  end
end
