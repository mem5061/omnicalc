class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ","").gsub("\n","").gsub("\r","").chomp.length

    @word_count = @text.split.count

    @occurrences = @text.downcase.gsub(/[^a-z0-9 ]/i,"").split.count(@special_word.downcase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f
    @monthly_rate = ((@apr/100)/12)
    @number_of_pmts = @years*12


    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = @principal * ((@monthly_rate*(1+@monthly_rate)**@number_of_pmts)/(((1+@monthly_rate)**@number_of_pmts)-1))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = (@ending - @starting)/60
    @hours = ((@ending - @starting)/60)/60
    @days = (((@ending - @starting)/60)/60)/24
    @weeks = ((((@ending - @starting)/60)/60)/24)/7
    @years = (((((@ending - @starting)/60)/60)/24)/7)/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum


        @median =  (@sorted_numbers[(@sorted_numbers.length - 1) / 2] + @sorted_numbers[@sorted_numbers.length / 2]) / 2.0

    @sum = @numbers.sum

    @mean = @sum/@count

  var_sum = @numbers.map{|n| (n-@mean)**2}.inject(:+).to_f
    @variance = var_sum / (@numbers.length - 1)

    @standard_deviation = Math.sqrt(@variance)


    @mode = @numbers.max_by { |i| @numbers.count(i) }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
end
end
