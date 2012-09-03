# encoding: UTF-8

class MeetupMember
  include Mongoid::Document


  def correct_name
    name.parameterize.gsub("-", " ").camelize
  end


end
