# How To Use

## AllOverIt::Utils module

### #self.as_instance
This static method checks whether the argument is a class or an instance. If a class is provided, it returns a default initialized instance of the class. If an instance is provided, it returns the instance as is.

```ruby
class SomeClass
end

# Will create an instance of SomeClass and return it
instance1 = AllOverIt::Utils.as_instance(SomeClass)

# instance2 will be the same as instance1
instance2 = AllOverIt::Utils.as_instance(instance1)
```


### #self.ensure_instance_includes
This static method checks that an instance variable includes a specified module. The instance is returned if its' ancestor chain includes the module, otherwise an ArgumentError is raised.

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


### #self.ensure_instance_is_a
This static method checks that an instance variable inherits a specified class. The instance is returned if it inherits the specified class, otherwise an ArgumentError is raised.

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
