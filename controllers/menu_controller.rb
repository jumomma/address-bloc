# #1 include AddressBook using require_relative
require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    # #2 display the main menu options to the command line
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - View Entry Number n"
    puts "6 - Delete all entries"
    puts "7 - Exit"
    print "Enter your selection: "

    # #3 retrieve user input from the command line using gets
    selection = gets.to_i

    # #7 use a case statement operator to determine the proper response to user's input
    case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
        system "clear"
        create_entry
        main_menu
      when 3
        system "clear"
        search_entries
        main_menu
      when 4
        system "clear"
        read_csv
        main_menu
      when 5
        system "clear"
        view_entry
        main_menu
      when 6
        system "clear"
        address_book.demolish
        puts "All entries have been deleted"
        main_menu
      when 7
        puts "Good-bye!"
        # #8 terminate the program using exit(0). 0 signals the program to exit without an error.
        exit(0)
      # #9 use else to catch invalid user input and prompt to retry
      else
        system "clear"
        puts "Sorry, that is not a valid input"
        main_menu
      end
    end


    # #10
    def view_all_entries
      # #14 iterate through all entries in AddressBook using each
      address_book.entries.each do |entry|
        system "clear"
        puts entry.to_s
      # #15 call entry_submenu to display a submenu for each entry
        entry_submenu(entry)
      end

      system "clear"
      puts "End of entries"
    end


    def create_entry
      # #11 clear the screen before display create entry prompts
      system "clear"
      puts "New AddressBloc Entry"
      # #12 use print to prompt the user for each entry attribute
      print "Name: "
      name = gets.chomp
      print "Phone number: "
      phone = gets.chomp
      print "Email: "
      email = gets.chomp

      # #13 add a new entry to address_book using add_entry
      address_book.add_entry(name, phone, email)

      system "clear"
      puts "New entry created"
    end

    def entry_submenu(entry)
      # #16 display submenu option
      puts "n - next entry"
      puts "d - delete entry"
      puts "e - edit this entry"
      puts "m - return to main menu"
      # #17 chomp removes any trailing whitespace from the string
      selection = gets.chomp

      case selection
      # #18 do nothing and return control to view_all_entries
        when "n"
      # #19
        when "d"
      # #7 when use is viewing submenu presses d delete_entry is called, once deleted, control will return to view_all_entries
          delete_entry(entry)
        when "e"
      # #8 display sub-menu w/ entry_submenu for the entry under edit
          edit_entry(entry)
          entry_submenu(entry)
      # #20
        when "m"
          system "clear"
          main_menu
        else
          system "clear"
          puts "#{selection} is not a valid input"
          entry_submenu(entry)
        end
      end

    def view_entry
      # prompt user for entry number
      print "Enter Entry Number to view: "
      selection = gets.chomp.to_i

      if selection < address_book.entries.count
        puts address_book.entries[selection]
        puts "Press Enter to return to the main menu"
        gets.chomp
        system "clear"
      else
        puts "#{selection} could not be found"
        view_entry
      end
    end
      # loop through entries to find the entry number then display it to the user


    def search_entries
      # #9 get the name of use for search
      print "Search by name: "
      name = gets.chomp
      # #10 call search on address_book which will return a match or nil
      match = address_book.binary_search(name)
      system "clear"
      # #11
      if match
        puts match.to_s #check if search returned a match
        search_submenu(match)
      else
        puts "No match found for #{name}"
      end
    end

    def read_csv
      # #1 prompt to enter csv file to import
      print "Enter CSV file to import: "
      file_name = gets.chomp

      # #2 check to see if file name is empty; if so, return user to main menu
      if file_name.empty?
        system "clear"
        puts "No CSV file read"
        main_menu
      end

      # #3
      begin #protects the program from crashing if an exception is thrown
        entry_count = address_book.import_from_csv(file_name).count #import the file with import_from_csv on address_book
        system "clear"
        puts "#{entry_count} new entries added from #{file_name}"
      rescue
        puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
        read_csv
      end

      def delete_entry(entry)
        address_book.entries.delete(entry)
        puts "#{entry.name} has been deleted"
      end

      def edit_entry(entry)
        # #4 each gets.chomp statement gathers user input and assigns it to an appropriately named variable
        print "Updated name: "
        name = gets.chomp
        print "Updated phone number: "
        phone_number = gets.chomp
        print "Updated email: "
        email = gets.chomp
        # #5 use !attribute.empty? to set attributes on entry only if a valid attr was read from user input
        entry.name = name if !name.empty?
        entry.phone_number = phone_number if !phone_number.empty?
        entry.email = email if !email.empty?
        system "clear"
        # #6 print out entry with the updated attributes
        puts "Updated entry: "
        puts entry
      end

      def search_submenu(entry)
        # #12 print out submenu for an entry
        puts "\nd - delete entry"
        puts "e - edit this entry"
        puts "m - return to main menu"
        # #13 save the user input to selection
        selection = gets.chomp

        # #14
        case selection
          when "d"
            system "clear"
            delete_entry(entry)
            main_menu
          when "e"
            edit_entry(entry)
            system "clear"
            main_menu
          when "m"
            system "clear"
            main_menu
          else
            system "clear"
            puts "#{selection} is not a valid input"
            puts entry.to_s
            search_submenu(entry)
        end
      end
    end
  end
