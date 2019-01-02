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

      for i in (1..20)
        word_hash[i] = []
      end

      file = File.join(Rails.root, 'lib', 'assets', 'dictionary.txt')
      File.foreach(file) do |word|
        word_hash[word.length] << word.downcase.chop.to_s
      end

      mapped_keys = phone_number.chars.map do |digit|
        num_hash[digit]
      end

      grouped_hash = {}
      number_of_digits = mapped_keys.length - 1

      for i in (2..number_of_digits - 2)
        array1 = mapped_keys[0..i]
        if array1.length < 3
          next
        end
        array2 = mapped_keys[i + 1..number_of_digits]
        if array2.length < 3
          next
        end
        combo1 = array1.shift.product(*array1).map(&:join)
        if combo1.nil?
          next
        end
        combo2 = array2.shift.product(*array2).map(&:join)
        if combo2.nil?
          next
        end
        grouped_hash[i] = [(combo1 & word_hash[i+2]), (combo2 & word_hash[number_of_digits - i +1])]
      end

      result = []

      grouped_hash.each do |key, collection|
        next if collection.first.nil? || collection.last.nil?
        collection.first.product(collection.last).each do |combination|
          result << combination
        end
      end

      result << (mapped_keys.shift.product(*mapped_keys).map(&:join) & word_hash[11]).join(", ")
      result = result.sort{|a, b| a.to_s <=> b.to_s}
      @final_combination = result

    else
      flash[:info] = "Please enter the phone number"
    end
  end
end
