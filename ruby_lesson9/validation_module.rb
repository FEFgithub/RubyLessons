module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name_attr, type_attr, *args)  
      if @valid_arr.nil?
        @valid_arr = []
        @valid_arr << [name_attr, type_attr, args]
      else
        @valid_arr << [name_attr, type_attr, args]
      end
    end
  end

  module InstanceMethods
    def validate! 
      @type_error = {}  
      self.class.instance_variable_get(:@valid_arr).each do |valid_zero|
        if valid_zero[1] == :presence
          @type_error[:presence] = 'Attr is nil or empty string!' if eval(valid_zero[0].to_s).nil? ||
                                                          eval(valid_zero[0].to_s) == ''
        end
        if valid_zero[1] == :format
          @type_error[:format] = 'Attr format do not correct!' if eval(valid_zero[0].to_s) !~ eval(valid_zero[2].to_s)[0]
        end
        if valid_zero[1] == :type
          @type_error[:type] = 'Attr type do not correct!' if eval(valid_zero[0].to_s).class != eval(valid_zero[2].to_s)[0] 
        end
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
