class Loan
  def initialize(book)
    @book = book
    @time = Loan.time_class.now
  end

  def self.time_class
    @time_class || Time
  end

  def to_s
    "#{@book.upcase} loaned on #{@time}"
  end
end

#------Test-------

class FakeTime
  def self.now
    'Mon Apr 06 12:15:50'
  end
end

require 'minitest/autorun'

class TestLoan < Minitest::Test
  def test_to_s
    Loan.instance_eval {@time_class = FakeTime}
    loan = Loan.new('War and Peace')
    assert_equal 'WAR AND PEACE loaned on Mon Apr 06 12:15:50', loan.to_s
  end
end