class Item

    attr_accessor :title, :description
    attr_reader :deadline, :done

    def self.valid_date?(date)
        digits = date.split("-")
        return false if digits.length != 3
        return false if digits[2].to_i > 31 ||  digits[2].to_i < 1
        return false if digits[1].to_i > 12 ||  digits[2].to_i < 1
        return false if digits[0].length != 4
        true
    end

    def initialize(title, deadline, description)
        @title = title
        @deadline = deadline
        @description = description
        @done = false

        if !Item.valid_date?(@deadline)
            raise "invalid date"
        end
    end

    def deadline=(new_deadline)
        if Item.valid_date?(new_deadline)
            @deadline = new_deadline
        else
            raise "not a valid date"
        end
    end

    def toggle
        if @done == false
            @done = true
        else
            @done = false
        end
    end

end 