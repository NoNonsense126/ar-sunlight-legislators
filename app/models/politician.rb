require_relative '../../db/config'

class Politician < ActiveRecord::Base
  def fullname
    has_many :tweets
    middlename == ""? middle = "": middle = " #{middle}"
    firstname + middle + " " + lastname
  end

end





