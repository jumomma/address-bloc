# #8 tell ruby to load the library named entry.rb relative to address_book.rb's file path
require_relative 'entry'

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

    def remove_entry(name, phone_number, email)
      delete_entry = nil

      entries.each do |entry|
        if name == entry.name && phone_number == entry.phone_number && email == entry.email
          delete_entry = entry
        end
      end

      entries.delete(delete_entry)
    end


end
