class Item < ApplicationRecord
    has_many :practices

    def to_s
        name
    end
end
