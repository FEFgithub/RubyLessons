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
    def valid_presence
      self.class.instance_variable_get(:@validation).each do |valid|
        @type_error[:presence] = 'Attr is nil or empty string!' if eval(valid[:attr].to_s).nil? ||
                                                                   eval(valid[:attr].to_s) == ''
      end
    end

    def valid_format
      self.class.instance_variable_get(:@validation).each do |valid|
        @type_error[:format] = 'Attr format do not correct!' if eval(valid[:attr].to_s) !~ eval(valid[:option].to_s)[0]
      end
    end 

    def valid_type
      self.class.instance_variable_get(:@validation).each do |valid|
        @type_error[:type] = 'Attr type do not correct!' if eval(valid[:attr].to_s).class != eval(valid[:option].to_s)[0]
      end
    end

    def validate! 
      @type_error = {}  
      self.class.instance_variable_get(:@validation).each do |valid|
        valid_presence if valid[:type] == :presence
        valid_format if valid[:type] == :format
        valid_type if valid[:type] == :type
      end
      puts @type_error[:presence] if !@type_error[:presence].nil?
      puts @type_error[:format] if !@type_error[:format].nil?
      puts @type_error[:type] if !@type_error[:type].nil?
    end

    def valid?
      instance_variable_get(:@type_error) == {} ? true : false
    end 
  end
end
