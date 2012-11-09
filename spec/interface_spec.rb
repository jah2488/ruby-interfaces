require 'interface'
# TEST CLASS
class NodeInterface
  def hello;  end
  def johnny; end
  def add(first, second); end
  def self.used; end
end

describe Interface do

  it "has no errors when implemented properly" do
    lambda {
        class Yes
          include Interface
          def hello; end
          def johnny; end
          def add(first, second); end
          def self.used; end
          implements NodeInterface
        end
      }.should_not raise_error
  end

  it "raises an error when an instnace method is not implemented" do
    lambda {
      class Nope
        include Interface
        def hello; end
        def add(first, second); end
        def self.used; end
        implements NodeInterface
      end
    }.should raise_error MethodNotImplemented, "Method: johnny from Interface[NodeInterface] was not Implemented"
  end

  it "raises an error when a class method is not implemented" do
    lambda {
      class NopeClass
        include Interface
        def hello; end
        def add(first, second); end
        def johnny; end
        implements NodeInterface
      end
    }.should raise_error MethodNotImplemented, "Method: used from Interface[NodeInterface] was not Implemented"
  end

  it "raises an error when instance method is implemented with wrong number of arguements." do
    lambda {
      class Nope
        include Interface
          def hello; end
          def johnny; end
          def add(first); end
          def self.used; end
          implements NodeInterface
      end
    }.should raise_error ArgumentError
  end

  it "raises an error when a class method is implemented with wrong number of arguements." do
    lambda {
      class NopeClass
        include Interface
          def hello; end
          def johnny; end
          def add(first, second); end
          def self.used(times); end
        implements NodeInterface
      end
    }.should raise_error ArgumentError
  end

  it "should raise exception if method is not defined on Interface " do
    lambda {
      a = class MyFace
        include Interface
        def hello;  end
        def johnny; end
        def add(first, second); end
        def self.used; end
        def im_not_supposed_to_be_here; end
        implements NodeInterface
      end
    }.should raise_error MethodNotDefined, "Method: im_not_supposed_to_be_here is not defined on Interface[NodeInterface]"
  end

  it "should raise exception if class method is not defined on Interface " do
    lambda {
      a = class Myself
        include Interface
        def hello;  end
        def johnny; end
        def add(first, second); end
        def self.used; end
        def self.i_am_hiding; end
        implements NodeInterface
      end
    }.should raise_error MethodNotDefined, "Method: i_am_hiding is not defined on Interface[NodeInterface]"
  end

end
