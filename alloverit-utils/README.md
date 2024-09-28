# AllOverIt::Utils

This general purpose utility gem primarily exists to support other **AllOverIt** gems. Take a look, you might find something useful for your own projects.

You can find the source at `lib/alloverit/utils`.


## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add alloverit-utils
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install alloverit-utils
```


## Dependencies
None.


## Usage

### AllOverIt::Utils.as_instance
This method checks whether the argument is a class or an instance. If a class is provided, it returns a default initialized instance of the class. If an instance is provided, it returns the instance as is.

```ruby
class SomeClass
end

# Will create an instance of SomeClass and return it
instance1 = AllOverIt::Utils.as_instance(SomeClass)

# instance2 will be the same as instance1
instance2 = AllOverIt::Utils.as_instance(instance1)
```


### AllOverIt::Utils.ensure_instance_includes
This method checks that an instance variable includes a specified module. The instance is returned if its' ancestor chain includes the module, otherwise an ArgumentError is raised.

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


### AllOverIt::Utils.ensure_instance_is_a
This method checks that an instance variable inherits a specified class. The instance is returned if it inherits the specified class, otherwise an ArgumentError is raised.

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


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
