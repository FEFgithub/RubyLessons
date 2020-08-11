module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name_attr, type_attr, *args)
      @var = 'test00001'  
    end
  end

  module InstanceMethods
    def validate!
      # @type_error = nil
      # puts instance_variable_get(:@type_attr)  
      # if instance_variable_get(:@type_attr) == :presence
      #   @type_error = 'Attr is nil or empty string!' if instance_variable_get(:@name_attr).nil? || 
      #                                                   instance_variable_get(:@name_attr) == '' 
      # elsif instance_variable_get(:@type_attr) == :format
      #   @type_error = 'Attr format do not correct!' if instance_variable_get(:@name_attr) !~ instance_variable_get(:@args)[0]
      # elsif instance_variable_get(:@type_attr) == :type
      #   @type_error = 'Attr type do not correct!' if instance_variable_get(:@name_attr).class != instance_variable_get(:@args)[0]
      # else
      #   puts 'Enter correct type_attr - :presence, :format, :type' 
      # end
      # puts @type_error if !@type_error.nil?
      puts self.class.instance_variable_get(:@var)
    end

    def valid?
      instance_variable_get(:@type_error) ? false : true
    end 
  end
end
