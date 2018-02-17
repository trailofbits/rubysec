# Mutant Level 1
In this exercise you will learn how to achieve full test coverage over all edge-cases by leveraging [Mutation Testing](http://en.wikipedia.org/wiki/Mutation_testing). In the past you may have tested code by fuzzing the inputs to methods. Instead of fuzzing the inputs of methods, Mutation Testing fuzzes the _behaviour_ of the code and then running the tests against the mutated code. Since the code now has different behaviour, the tests _should_ fail. When every mutation causes a test to fail, you have reached complete test coverage.

## Challenge
Your task is to write the missing [RSpec](http://rspec.info/) tests for `SecureDB::Document#grant_access` and `SecureDB::Document#revoke_access` in the `spec` directory. These methods are very important, as they control whether a User has access to a Document. An untested edge-case in either of these methods could expose classified information. This is where Mutation Testing comes in. Write the tests, verify they pass, and then run Mutant to see if the tests you've written cover all of the edge-cases for the application.

### Pointers
* Start by reading the code under test to learn where the edge-cases are
* Write your tests to try and cover the edge cases
  - Obviously, if you don't know Rspec, this will be difficult
  - Build them out until they pass under normal conditions
  - After they pass, run them with mutant to check all edge cases
  - Keep updating tests until everything is green

### Workflow
There are two rake tasks to help you:

* `rake spec`: Runs the RSpec tests.
* `rake mutate`: Runs the [Mutant](https://github.com/mbj/mutant#readme) tool against RSpec test suite.

[Mutant](https://github.com/mbj/mutant#readme) can also be ran against individual methods:

    bundle exec mutant -I lib/ -r secure_db --use rspec "SecureDB::Document#grant_access"

When `rake mutant` prints all green, you have achieved full test coverage.

## Level 1 Files
* [Mutant Level 1](https://github.com/trailofbits/rubysec/tree/master/mutant/mutant1)
