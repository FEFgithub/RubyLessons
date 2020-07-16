module NameCompany
  attr_accessor :name_company 
end

module InstanceCounter
  def self.included(base) 
    base.extend ClassMethods
    base.send :include, InstanceMethods 
  end

  module ClassMethods 
    attr_accessor :instances
  end

  module InstanceMethods
    def register_instance
      self.class.instances = self.class.instances.to_i + 1
    end
  end
end
