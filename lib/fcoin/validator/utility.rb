require 'pry'
module Fcoin
  module ValidatorUtility
    def includes_error_message(target, target_type, list)
      message = {}
      target_value = target.present? ? target : 'nil'
      message[target_type] = "#{target_type} is #{target_value}. #{target_type} is not included in the [#{list.join(', ')}]."
      message
    end

    def between_error_message(target, target_type, min, max)
      message = {}
      target_value = target.present? ? target : 'nil'
      message[target_type] = "#{target_type} is #{target_value}. #{target_type} is not between #{min} and #{max}."
      message
    end

    def presence_error_message(target, target_type)
      message = {}
      target_value = target.present? ? target : 'nil'
      message[target_type] = "#{target_type} is #{target_value}. #{target_type} can't be blank"
      message
    end
  end
end
