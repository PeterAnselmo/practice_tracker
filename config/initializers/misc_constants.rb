
DATETIME_COMMON = "%b %e, %l:%M %p"

class Integer
    def to_descriptive_time
        hours = self / 3600
        minutes = (self % 3600) / 60
        interval = ''
        if hours > 1
            interval += "#{hours} hours " if hours > 0
        elsif hours == 1
            interval += "#{hours} hour " if hours > 0
        end
        interval += "#{minutes} minutes"
        interval
    end
end
