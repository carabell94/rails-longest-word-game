require 'open-uri'

class GamesController < ApplicationController
  def new
    # display a new random grid and a form for input
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    # POST will submit the form to the score page/action
    @letters = params[:letters].split
    @word = params[:word]
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = open(url)
    json = JSON.parse(response.read)
    json['found']
  end
end
