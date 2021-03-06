class Debit < ActiveRecord::Base
    belongs_to :transaction
    belongs_to :character
    
    validates_presence_of :character_id, :if => "other_source.nil?"
    validates_presence_of :other_source, :if => "character_id.nil?"
    
    auto_strip_attributes :other_source
    
    def subject_name
        unless character.nil?
            character.name_and_title
        else
            other_source
        end
    end

end
