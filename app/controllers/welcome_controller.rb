class WelcomeController < ApplicationController
  def index
    if(params[:q])
      phone_number = params[:q]

      if phone_number.nil? || phone_number.length != 10
        return Array.new
      end

      num_hash = {
        '2' => ['a','b','c'],
        '3' => ['d','e','f'],
        '4' => ['g','h','i'],
        '5' => ['j','k','l'],
        '6' => ['m','n','o'],
        '7' => ['p','q','r','s'],
        '8' => ['t','u','v'],
        '9' => ['w','x','y','z']
      }

      word_hash = {}

      for i in (1..15)
        word_hash[i] = []
      end

      file = File.join(Rails.root, 'lib', 'assets', 'dictionary.txt')
      dictionary = File.read(file)

      File.foreach(file) do |word|
        dictionary[word.length] << word.downcase.chop.to_s
      end

      @dictionary = dictionary

    else
      flash[:info] = "Please enter the phone number"
    end
  end
end
