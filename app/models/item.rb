class Item < ApplicationRecord
    has_many :practices

    VALID_TYPES = ['exercise', 'repertoire', 'rehersal']

    def to_s
        name
    end
end
