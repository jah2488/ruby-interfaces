module Interface

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def implements(class_name)
        interface_methods       = class_name.instance_methods(false)
        interface_class_methods = class_name.methods(false)
        klass_methods           = instance_methods(false)
        klass_class_methods     = methods(false)

        interface_methods.each do |method_name|
          raise_not_implemented(method_name, class_name) unless method_defined?(method_name)
        end
        interface_class_methods.each do |method_name|
          raise_not_implemented(method_name, class_name) unless klass_class_methods.include?(method_name)
        end
        klass_methods.each do |method_name|
          raise_not_defined(method_name, class_name)     unless interface_methods.include?(method_name)
          raise ArgumentError                            unless class_name.instance_method(method_name).parameters == instance_method(method_name).parameters
        end
        klass_class_methods.each do |method_name|
          raise_not_defined(method_name, class_name)     unless interface_class_methods.include?(method_name)
          raise ArgumentError                            unless class_name.method(method_name).parameters == method(method_name).parameters
        end
    end

    def raise_not_implemented(method_name, class_name)
        raise MethodNotImplemented, "Method: #{method_name} from Interface[#{class_name}] was not Implemented"
    end

    def raise_not_defined(method_name, class_name)
        raise MethodNotDefined, "Method: #{method_name} is not defined on Interface[#{class_name}]"
    end
  end
end

class MethodNotImplemented < StandardError
end

class MethodNotDefined < StandardError
end
