module Validation
  def validate(name_attr, type_attr, *args)
    @name_attr = name_attr
    @type_attr = type_attr
    @args = args
  end

  define_method(:validate!) do
    @type_error = nil  
    if @type_attr == :presence
      @type_error = 'Attr is nil or empty string!' if instance_variable_get("@#{@name_attr}").nil? || 
                                                      instance_variable_get("@#{@name_attr}") == '' 
    elsif @type_attr == :format
      @type_error = 'Attr format do not correct!' if instance_variable_get("@#{@name_attr}") !~ @args[0]
    elsif @type_attr == :type
      @type_error = 'Attr type do not correct!' if instance_variable_get("@#{@name_attr}").class != @args[0]
    else
      puts 'Enter correct type_attr - :presence, :format, :type' 
    end
    puts @type_error if !@type_error.nil?
  end

  define_method(:valid?) { instance_variable_get(:@type_error) ? false : true }
end
