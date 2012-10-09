#Interfaces#
## In Ruby! ##

### Its All The joys of static typing in ruby! ###
Just for fun, now you too can have run time errors when you class does not strictly adhere to the interface file it implements!

This project is a minimalistic approach to adding interface/contract agreement in ruby.

## Getting the project and running the tests ##

    git cone [this-repo]
    bundle
    rspec


## How it work? ##

First you have an interface

    class CarInterface

        def start
        end

        def stop
        end

        def self.drive
        end

     end

Then you have a class that Implements that class as an interface

    class Car
      include Interface

      def start
      end

      def stop
      end

      def self.drive
      end

      implements CarInterface #This is the magic line

And To-Da! you're done! This class now implements that Interface perfectly.

__But What if it didn't?__ - Funny you should ask, I was just about to get to that.

## Exceptions For Everyone ##

If you or your class does not adhere to the interface defined in the class its trying to implement, you will be met with one of two types of Exceptions. Either a `MethodNotDefined` exception or a `MethodNotImplemented` exception, depending on how you transgressed. Although the errors themselves are pretty self explanatory, it works like this.

`MethodNotImplemented` appears when your class fails to use a method defined in the interface. __You forgot to add one.__

`MethodNotDefined` appears when your class adds a method that is not part of the interface you are implementting. __You're making stuff up__
