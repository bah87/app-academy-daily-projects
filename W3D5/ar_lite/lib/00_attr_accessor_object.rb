class AttrAccessorObject
  
  def self.my_attr_accessor(*names)
    names.each do |name|
      # getter
      define_method(name) do
        self.instance_variable_get("@#{name.to_s}")
      end
      
      # setter
      define_method("#{name}=".to_sym) do |obj=nil|
        self.instance_variable_set("@#{name.to_s}", obj)
      end
    end
  end
  
end
