module Acсessors 
  def attr_accessor_with_history(*names)
    names.each do |name|
      my_var = "@#{name}".to_sym
      my_history_var = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(my_var) }
      define_method("#{name}=".to_sym) do |value| 
        instance_variable_set(my_var, value)
      end
      define_method("#{name}_history") do
        instance_variable_set(my_history_var, [])
        instance_variable_get(my_history_var) << instance_variable_get(my_var)  
      end
    end
  end  
  
  def strong_attr_accessor(name_attr, class_attr)
    my_var = "@#{name_attr}".to_sym
    define_method(name_attr) { instance_variable_get(my_var) }
    define_method("#{name_attr}=".to_sym) do |value|
      begin   
        instance_variable_set(my_var, value) if value.class == class_attr
      raise if value.class != class_attr 
      rescue 
        puts "Class must be #{class_attr}"
      end
    end
  end
end
