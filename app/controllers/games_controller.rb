require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    9.times{
      @letters << ("A".."Z").to_a.sample
    }
  end

  def score
    upper_input = params[:guess].upcase
    if contains_all_letters(upper_input, params[:letters]) == true && is_a_word(upper_input) == true
      @score = "Your score is: #{upper_input.length}"
    else
      @score = "Not a valid word"
    end
  end

  def contains_all_letters(input, grid)
    input.chars.all? do |letter|
      grid.count(letter) >= input.chars.count(letter)
    end
  end

  def is_a_word(input)
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    user["found"] == true
  end
end
