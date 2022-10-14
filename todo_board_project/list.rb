require "./item.rb"

class List
    attr_accessor :label

    def initialize(label)
        @label = label 
        @items = []
    end

    def add_item(title, deadline, *description)
        if Item.valid_date?(deadline)
            @items << Item.new(title, deadline, description.join(" "))
            return true
        else
            return false
        end
    end

    def size
        @items.length
    end

    def valid_index?(index)
        index >= 0 && index < self.size  
    end

    def swap(index_1, index_2)
        if valid_index?(index_1) && valid_index?(index_2)
            @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
            return true
        else
            return false
        end
    end

    def[](index)
        if valid_index?(index)
            @items[index]
        else
            return nil
        end
    end

    def priority
        @items[0]
    end

    def print
        puts "-------------------------------------------------"
        puts "            #{self.label.upcase}                 "
        puts "-------------------------------------------------"
        puts "Index  | Item             | Deadline |   Done    "
        puts "-------------------------------------------------"
        @items.each_with_index do |item, i|
            puts "#{i}".ljust(7) + "| #{item.title}".ljust(18) + " | #{item.deadline}".ljust(15) + "  | #{item.done}".ljust(10)
        end
        puts "-------------------------------------------------"    
    end

    def print_full_item(index)
        item = @items[index]
        puts "-----------------------------------------"
        puts "#{item.title}".ljust(15) + "#{item.deadline}".ljust(15) + "#{item.done}".ljust(10)
        puts "#{item.description}" if item.description != ""
        puts "-----------------------------------------"
    end

    def print_priority
        print_full_item(0)
    end

    def up(index, amount=1)
        return false if !valid_index?(index)
        while amount > 0 && index != 0
            swap(index, index - 1)
            index -= 1
            amount -= 1
        end
        true
    end

    def down(index, amount=1)
        return false if !valid_index?(index)
        while amount > 0 && index != size - 1
            swap(index, index + 1)
            index += 1
            amount -= 1
        end
        true
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline}
    end

    def toggle_item(index)
        item = self[index]
        item.toggle if !item.nil?
    end

    def remove_item(index)
        return false if !valid_index?(index)
        @items.delete_at(index)
        true
    end

    def purge
        @items.delete_if(&:done)
    end
    
end