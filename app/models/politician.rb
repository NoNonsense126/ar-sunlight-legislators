require_relative '../../db/config'

class Politician < ActiveRecord::Base
  def fullname
    middlename == ""? middle = "": middle = " #{middle}"
    firstname + middle + " " + lastname
  end

end





