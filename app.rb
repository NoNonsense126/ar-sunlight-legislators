require 'pathname'
require 'sqlite3'

APP_ROOT = Pathname.new(File.dirname(File.expand_path(__FILE__)))

require APP_ROOT.join('app', 'models', 'politician')
require APP_ROOT.join('lib', 'sunlight_legislators_importer')

class FindInfo

  def self.politician_in_state(state)
    puts "Senators:"
    Politician.where(state: state, title: "Sen" ).each do |senators|
      puts "  #{senators.fullname} (#{senators.party})"
    end
    puts "Representatives:"
    Politician.where(state: state, title: "Rep" ).each do |representative|
      puts "  #{representative.fullname} (#{representative.party})"
    end
  end

  def self.gender_percentage(gender)
    percentage, gender_num, gender_name = calculate_gender_percentage(gender, "Sen")
    puts "#{gender_name} Senators: #{gender_num} (#{percentage}%)"
    percentage, gender_num, gender_name = calculate_gender_percentage(gender, "Rep")
    puts "#{gender_name} Representatives: #{gender_num} (#{percentage}%)"
  end

  def self.states_and_representatives
    states_array = Politician.select(:state).map(&:state).uniq
    states_and_count = states_array.map do |state|
      [state, count_congresspeople(state)]
    end
    sorted_values = states_and_count.sort{ |a,b| b[1]<=>a[1] }
    sorted_values.each do |pairs|
      puts "#{pairs[0]}: #{count_senators(pairs[0])} Senators, #{count_representatives(pairs[0])} Representative(s)"
    end
  end

  def self.total_congresspeople
    puts "Senators: #{Politician.where(title: "Sen").count}"
    puts "Representatives: #{Politician.where(title: "Rep").count}"
  end

  def self.delete_inactive_member
    Politician.where(:in_office => false).destroy_all
  end



  private
  def self.calculate_gender_percentage(gender, title)
    total = Politician.where(title: "Sen", in_office: true).length
    gender_num = Politician.where(gender: gender, title: "Sen", in_office: true).length
    gender == "M"? gender_name = "Male": gender_name = "Female"
    percentage = ((gender_num.to_f/total)*100).round
    return percentage, gender_num, gender_name
  end

  def self.count_congresspeople(state)
    Politician.where(state: state, in_office: true).count
  end

  def self.count_senators(state)
    Politician.where(state: state, title: "Sen", in_office: true).count
  end

  def self.count_representatives(state)
    Politician.where(state: state, title: "Rep", in_office: true).count
  end


end

FindInfo.total_congresspeople
FindInfo.delete_inactive_member
FindInfo.total_congresspeople