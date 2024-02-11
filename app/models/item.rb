class Item < ApplicationRecord
    has_many :practices
    belongs_to :instrument

    VALID_TYPES = ['exercise', 'lesson', 'repertoire', 'rehersal', 'performance', 'creative']

    def to_s
        name
    end
end
