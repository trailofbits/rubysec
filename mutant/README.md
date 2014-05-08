Mutant
=====
Welcome to the Mutant module. This modules primary concern is on the concept of testing.

## Why Test?
Why testing, you might ask? Typically compiler features can eliminate many classes of bugs, but they cannot solve the halting problem. The only true way to know if your code will work is to run the code. In Ruby however, there aren't any error-checking compiler features, such as a strong type system, and so because of this testing is sort of a big deal.

### But Who Can Watch the Watchmen?
Here enters a problem, and the main focus of this module; in order for the tests to verify that the code is correct, the tests themselves must be correct, and moreover meaningful. The question then is, how do we verify the correctness of tests we've written? "We test our tests!" you say, and clearly this recurses to infinity and exhuasts your stack.

### Enter Mutation Testing
Thus we turn to mutation testing. This form of testing ensures that test cover all edge-cases of your developed code. Not only does mutation testing test the current state of your code, but it also changes the code under review to ensure that errors in the code result in failed tests as is expected. An example of this would be changing an `==` to `!=`, and similar concepts.  Using a mutation testing tool will ensure that all edge cases are covered, and furthermore mutation testing typically gives us a more reliable metric of test coverage as opposed to something like counting LoC coverage.

### Downsides
Generally, it's bad practice to write tests which are aware of the implementation, especially when using behavioral testing tools such as Rspec.  However, mutation testing often pushes you to write implementation-aware tests. The power of mutation testing thus lies in the number of techniques used to mutate the code under test.

### Mutant
Mutant is a Ruby library to perform (you guessed it) mutation testing. To use it, you simply feed it your Rspec tests and a module or class name, and it  Magically&trade; tests as many edge cases as it knows how to.

As you may have already guessed, the workshop for this section makes heavy use of both Ruby's Mutant and Rspec libraries.  If you have never used either of these you may want to consider running through the below material before starting the workshop:

* [Mutation Testing](http://en.wikipedia.org/wiki/Mutation_testing)
* [Mutant](https://github.com/mbj/mutant#readme)
* [RSpec](http://rspec.info/)
* [RSpec Tutorial](http://blog.davidchelimsky.net/blog/2007/05/14/an-introduction-to-rspec-part-i/)

## Workshop
Write the missing [RSpec](http://rspec.info/) tests for `SecureDB::Document#grant_access` and `SecureDB::Document#revoke_access`  in the `spec` directory. These methods are very important, as they control  whether a User has access to a Document. An untested edge-case in either of  these methods could expose classified information. This is where Mutation  Testing comes in. Write the tests, verify they pass, and then run Mutant to see if the tests you've written cover all of the edge-cases for the application.

There are two rake tasks to help you:

* `rake spec`: Runs the RSpec tests.
* `rake mutate`: Runs the [Mutant](https://github.com/mbj/mutant#readme) tool against RSpec test suite.

[Mutant](https://github.com/mbj/mutant#readme) can also be ran against individual methods:

    bundle exec mutant --rspec-full -r ./spec/document_spec.rb ::SecureDB::Document#grant_access

### Pointers
* Start by reading the code under test to learn where the edge-cases are
* Write your tests to try and cover the edge cases
  - Obviously, if you don't know Rspec, this will be difficult
  - Build them out until they pass under normal conditions
  - After they pass, run them with mutant to check all edge cases
  - Keep updating tests until everything is green

When `rake mutant` prints all green, you have achieved full test coverage.