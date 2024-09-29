# How To Use

**Quick Links**
* [AllOverIt::Utils module](#alloveritutils-module)
* [AllOverIt::Utils::Check module](#alloveritutilscheck-module)

## AllOverIt::Utils module

### .as_instance
This class method checks whether the argument is a class or an instance. If a class is provided, it returns a default initialized instance of the class. If an instance is provided, it returns the instance as is.

```ruby
class SomeClass
end

# Will create an instance of SomeClass and return it
instance1 = AllOverIt::Utils.as_instance(SomeClass)

# instance2 will be the same as instance1
instance2 = AllOverIt::Utils.as_instance(instance1)
```


### .ensure_instance_includes
This class method checks that an instance variable includes a specified module. The instance is returned if its' ancestor chain includes the module, otherwise an ArgumentError is raised.

```ruby
module SomeModule
end

class SomeClass
end

class AnotherClass
  include SomeModule
end

instance1 = SomeClass.new
instance2 = AnotherClass.new

# Will raise an ArgumentError
instance3 = AllOverIt::Utils.ensure_instance_includes(instance1, SomeModule)

# instance4 will be the same as instance2
instance4 = AllOverIt::Utils.ensure_instance_includes(instance2, SomeModule)
```


### .ensure_instance_is_a
This class method checks that an instance variable inherits a specified class. The instance is returned if it inherits the specified class, otherwise an ArgumentError is raised.

```ruby
module SomeModule
end

class SomeClass
end

class AnotherClass < SomeClass
end

instance1 = SomeClass.new
instance2 = AnotherClass.new

# Will raise an ArgumentError
instance3 = AllOverIt::Utils.ensure_instance_is_a(instance1, SomeOtherClass)

# instance4 will be the same as instance2
instance4 = AllOverIt::Utils.ensure_instance_is_a(instance2, SomeClass)
```


## AllOverIt::Utils::Check module

### .not_nil

Use this method to perform pre-condition checks on one or more method arguments to assert they are not nil.

```ruby
def do_something(arg1, arg2, arg3)
  AllOverIt::Utils::Check.not_nil(arg1: arg1, arg2: arg2, arg3: arg3)

  # ... remainder of the code here
end
```

If any argument is `nil` then an `ArgumentError` will be raised for that argument. The name of the symbol will be reported in the error.
