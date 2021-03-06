require 'open-uri'

URL_TO_PARSE = ARGV[0]
MINIMUM_OCCURANCES = ARGV[1].to_i
MINIMUM_WORD_LENGTH = ARGV[2].to_i

# list of stopwords
STOP_WORDS = ["a","able","about","above","abroad","according", "&nbsp;"] # etc

# read the page in
puts "\n\nOpening #{URL_TO_PARSE}..."
page = open(URL_TO_PARSE).read()

# First remove the script tags...
puts "Removing script content..."
page.gsub!(/<script.*?>[\s\S]*?<\/script>/i, "")

# then remove the markup...
puts "Removing mark-up..."
page.gsub!(/<\/?[^>]*>/, " ")

# trim the whitespace off the start and end of the lines...
puts "Tidying text..."
page.gsub!(/^[ \t]+|[ \t]+$/, " ")

# and the excess newlines...
page.gsub!(/\n{2,}/,"\n")

# then pull it all onto one line...
page.gsub!("\n"," ")

# now, strip out all punctuation...
puts "Removing punctuation..."
page.gsub!(/[\.|\,|\@|\!|\?|\-|\'|\(|\)]/, '')

# remove the excess spaces...
puts "Further tidying..."
page.gsub!(/ {2,}/," ")

# drop everything to the same case
page.downcase!

# now split it the string using spaces...
page_words = page.split(" ")

# how many words do we have?
puts "Found #{page_words.length} words, removing all words less than #{MINIMUM_WORD_LENGTH} characters in length."

# remove entries which have fewer letters than our parameter
page_words.delete_if{|word| word.length < MINIMUM_WORD_LENGTH}

# how many did we end up with?
puts "Ended up with #{page_words.length} words."

# remove the stop words from the list
puts "Removing stop words from list..."
cleaned_page_words = page_words - STOP_WORDS
puts "Ended up with #{cleaned_page_words.length} words."

# create a hash to hold the words and number of occurances
words_and_occurances = {}

# go through all the cleaned words creating a hash for each, start with no instances, just to get the keys.
cleaned_page_words.each{|word| words_and_occurances[word] = 0}

# then go through again adding up the number of occurances
cleaned_page_words.each{|word| words_and_occurances[word] +=1 }

# sort the list by number of occurances
puts "Sorting by frequency..."
sorted_words_and_occurances = words_and_occurances.sort_by{|k,v| -v }

# output the end result...
puts "Filtering words that occur less than #{MINIMUM_OCCURANCES} times.\n\n"
puts "Here's your words...\n\n"
sorted_words_and_occurances.each do |word,occurances|
	if occurances > MINIMUM_OCCURANCES then
		render "#{occurances} occurances of #{word} and density #{"%0.2f" %((occurances.to_f/page_words.length.to_f)*100)}%"
		puts "#{occurances} occurances of #{word} and density #{"%0.2f" %((occurances.to_f/page_words.length.to_f)*100)}%"
	end
end
