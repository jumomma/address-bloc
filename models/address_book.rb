# #8 tell ruby to load the library named entry.rb relative to address_book.rb's file path
require_relative 'entry'
require "csv"

  class AddressBook
    attr_reader :entries

    def initialize
      @entries = []
    end

    def add_entry(name, phone_number, email)
      # #9 create var to store the insertion index
      index = 0
      entries.each do |entry|
      # #10 compare name with the name of the current entry
        if name < entry.name
          break
        end
        index+=1
      end
      # #11 insert a new entry into entries using the calculated index
      entries.insert(index, Entry.new(name, phone_number, email))
    end

    # #7 method starts by reading the file using file.read. CSV class is
       # is used to parse the file
    def import_from_csv(file_name)
      csv_text = File.read(file_name)
      csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
    # #8 iterate over the CSV::Table rows then create a hash for each row, convert each row_hash
        #to an Entry by using the add_entry method
      csv.each do |row|
        row_hash = row.to_hash
        add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
      end
    end

    def remove_entry(name, phone_number, email)
      delete_entry = nil

      entries.each do |entry|
        if name == entry.name && phone_number == entry.phone_number && email == entry.email
          delete_entry = entry
        end
      end

      entries.delete(delete_entry)
    end

    def binary_search(name)
      # #1
      lower = 0 # save the index of the leftmost item in the array in var lower
      upper = entries.length - 1 #save index of rightmost item in var upper

      # #2 # loop thru while lower index is less than or eq to upper
      while lower <= upper
        # #3 fine middle index by taking sum of lower + upper then dividing by 2
        mid = (lower + upper) / 2
        mid_name = entries[mid].name #retrieve name of entry at the middle index and store in mid_name

        # #4
        if name == mid_name #compare name to middle index / == case sensitive
          return entries[mid]
        elsif name < mid_name #If name is alphabetically before mid_name, then we set upper to mid - 1 because the name must be in the lower half of the array.
          upper = mid - 1
        elsif name >  mid_name #If name is alphabetically after mid_name, then we set lower to mid + 1 because the name must be in the upper half of the array.
          lower = mid + 1
        end
      end

      # #5 if we divide and conquer until no match is found, we return nil
      return nil
    end

    def iterative_search(name)
      entries.each do |entry|
        if entry.name == name
          return entry
        end
      end
      return nil
    end
end
