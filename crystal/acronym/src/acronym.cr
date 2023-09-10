module Acronym
  def self.abbreviate(phrase : String) : String
    phrase.split(/[-_\s]/, remove_empty: true).map { |e| e[0].upcase }.join
  end
end
