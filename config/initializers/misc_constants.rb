
DATETIME_COMMON = "%b %e, %l:%M %p"

class Integer
    def to_descriptive_time
        hours = self / 3600
        minutes = (self % 3600) / 60
        "#{hours} hours #{minutes} minutes"
    end
end
