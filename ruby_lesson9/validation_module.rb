module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name_attr, type_attr, *args)  
      @validation ||= []
      @validation << { attr: name_attr, type: type_attr, option: args }
    end
  end

  module InstanceMethods
    def valid_presence(attr, *options)
        raise if attr.nil? || attr == ''
    end

    def valid_format(attr, *options)
        raise if attr !~ options[0]
    end 

    def valid_type(attr, *options)
        raise if attr.class != options[0]
    end 

    def validate! 
      @type_error = {}  
      self.class.instance_variable_get(:@validation).each do |valid|
        valid_presence(eval(valid[:attr].to_s)) if valid[:type] == :presence
        valid_format(eval(valid[:attr].to_s), valid[:option]) if valid[:type] == :format
        valid_type(eval(valid[:attr].to_s), valid[:option]) if valid[:type] == :type
      end
      puts @type_error[:presence] if !@type_error[:presence].nil?
      puts @type_error[:format] if !@type_error[:format].nil?
      puts @type_error[:type] if !@type_error[:type].nil?
    end

    def valid?
      validate!
      true
    rescue
      false
    end 
  end
end
