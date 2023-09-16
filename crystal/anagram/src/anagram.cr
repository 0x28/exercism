module Anagram
  def self.find(subject : String, candidates : Array(String)) : Array(String)
    subject_count = count(subject)
    candidates.select { |candidate|
      candidate.compare(subject, case_insensitive: true) != 0 &&
        count(candidate) == subject_count
    }
  end

  private def self.count(s : String) : Hash(Char, Int32)
    count = Hash(Char, Int32).new(0)
    s.chars.map { |c| count.update(c.downcase) { |v| v + 1 } }

    count
  end
end
