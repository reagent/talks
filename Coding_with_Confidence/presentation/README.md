# Coding with Confidence: Adding TDD to Your Toolset

There are a few goals I have in mind that I hope to accomplish in both researching and delivering this talk. As a software developer, I have found Test-Driven Development to be an essential practice in my programming work and I want to enumerate the reasons why this is so.  For this talk, I want to:

* Define Test-Driven Development - what it is and what it isn't
* Describe the process that I follow when using a TDD style for writing code
* Demonstrate a successful approach to a TDD process

I use the word "confidence" in the title for this talk.  What does that mean?  As developers we have a desire for our code to be both correct and bug-free.  On some level, this is what I mean when I say "confidence." I want to be sure that I'm writing the right code to solve a particular business problem - no more and no less.  But I also want that code to have the correct design, I want the individual components to be highly cohesive and highly orthogonal - the places where those components interact with one another should be carefully thought out as they are implemented.  

As developers, we know that change is inevitable.  Our programs evolve over time and our designs are extended and changed as we work to meet the needs of the business processes that we're modeling.  As we evolve our code and work to remove any duplication that exists we want to be sure that this activity isn't introducing regressions.

## Why Test?

Testing when performed as part of a Quality Assurance (QA) process is about finding and fixing defects in software applications.  Testers work to expose a bug, file a report with the developers, and the developers work to fix that bug.  Lather, Rinse, Repeat.  It's also a tool that will allow stakeholders to verify that the finished application (or the current build) matches the expectations defined in the specifications. I should note that these specifications aren't necessarily the product of a Waterfall software development approach, iterative processes specify application behavior and functionality during the start of each cycle.

## How is a Test-First Approach Different?

At first glance, it might appear that test-first is about testing as a means to discover and fix software bugs.  To some degree this is true, but the means by which we fix software bugs in a test-first approach is not to create them in the first place.  It's a common misconception to treat a test-first approach as though it is a QA activity, when it really is more of a design activity.  

> "When you write unit tests, TDD-style or after your development, you scrutinize, you think,
> and often you prevent problems without even encountering a test failure." - Michael Feathers

From the outside, the term "Test-Driven Development" causes people to focus on the *testing* aspect of the process, when they should really be focusing on the *design* aspect.  It is for this reason that there is a shift to call this process "Test-Driven Design" or even "Behavior-Driven Development."  In addition to design, a test-first approach provides insurance against regressions and can act as a source of documentation for other developers.

### Design

The process that we take as part of a test-first approach is:

1. Design the API
1. Make it work
1. Make it clean

These are simple steps, but they have a powerful impact on how we write code.  This process forces us to think about the design of our interface and how simple (or complex) it is to use, because we are required to use it when we test.  If it's complicated to test, it's complicated to use, and we should re-think the design before progressing further.

The design that we strive for when developing individual software components should involve high cohesion within modules and low coupling (i.e. high orthogonality) between modules.  Code in a module should belong in that module, and those places where one module interacts with another should be both minimal and well-designed.  In this way, we avoid complicated solutions to simple problems because we are constantly thinking about the details of the code and making changes when we're not happy.

> "As long as you don't change that component's external interfaces, you can be comfortable that 
> you won't cause problems that ripple through the entire system." - The Pragmatic Programmer

Once we're happy with the design of our interactions with the code, we can then focus on making it behave in the way that we describe in the test.  During this process, you're just trying to get the test to pass in any way that you can.  Once it's working, you can revisit your code and remove any duplication or mess that you encounter.  Or, put more simply:

> "Clean code that works" - Ron Jeffries

The tests that you have built up during this process allow you to shape the code into the ideal without fearing that you're breaking existing functionality.

### Insurance

You've built up your protection against regressions in your code through tests, so that gives you the ability to be fearless against change.  You can confidently remove code that is commented-out or otherwise dead.  If your project has only active, maintained code, the risk of sloppiness creeping into the project is diminished.

> Consider a building with a few broken windows. If the windows are not repaired, the tendency is for
> vandals to break a few more windows. Eventually, they may even break into the building, and if it's
> unoccupied, perhaps become squatters or light fires inside. - The Atlantic Monthly (1982)

If you're maintaining your code, you're making it clear that someone cares about it, and test-first is a good strategy to give you the confidence in removing what you no longer need.  Fear reckless change, but do not fear change in your code if you are backed up by a suite of tests.

### Documentation

The jury's still out on this one.  Some proponents of tests as documentation believe that it can serve as the only documentation for a software application.  While this may or not be true for a given application, tests can certainly give other developers on the project an understanding of how a method behaves under test.  It may not indicate *why* it behaves in that fashion, so this is an area where deliberate naming or even additional documentation is valuable.

Despite that limitation, developers who want to use your code can refer to the tests you've written to see how you designed your code to be used.  You are communicating intention through your tests.

### A Test-First Approach

Revisiting the approach above, our goal is to:

1. Design the API (write a failing test)
2. Make it work   (make that test pass)
3. Make it clean  (refactor duplication)

Since we're thinking about how we want our code to work, simply start with a failing test.  This is our ideal of the way we want to both design and interact with our code.  Instead of sketching on a whiteboard or writing some pseudocode on a piece of paper, we can think in executable code.

Once we have the ideal implementation (expressed as a failing test), do the simplest thing to make that test pass.  Each time you get a test to pass, evaluate your work to ensure that you have not introduced duplication.  If there is duplicate code in your implementation, duplicate data between your test and code, or duplicate code in the tests themselves, work to remove that duplication.  Feel free to make any changes you want in this phase as long as you're not adding new functionality - the existing tests act as a safety net, giving you immediate feedback if you should make a mistake.

Since this is a different approach to writing code, you may get stuck during the process.  The important thing to remember is that you are in control of the steps that you are taking.  If you find yourself going too fast, write smaller, more focused tests.   If you feel like this is drudgery, try taking bigger steps to see where that gets you.

If you find yourself stuck on what to do, make sure to just do something.  If it's stupid, you can delete it after the fact, but you should feel free to experiment during this process.

### Test Anatomy

A breakdown of a `Test::Unit` test case: 

    class FabricatedTest < Test::Unit::TestCase # Test case
  
      def setup                                 # Test setup
        File.touch('tempfile')                  # (run before each test)
      end
  
      def teardown                              # Test teardown
        FileUtils.rm('tempfile')                # (run after each test)
      end
  
      def test_should_know_the_number_of_items  # Test
        bag = Bag.new(3)
        assert_equal 3, bag.item_count          # Assertion
      end
  
    end

## Pitfalls

Quite often, it's easy to get in the habit of just testing (seeing that green is addictive) without thinking about what value you're getting out of those tests.  While tests are an important artifact of this process, they too are code that needs to be maintained as part of the project.  Just like your implementation code, make sure that all testing code you write is necessary for your application.

Some common traps that people fall into:

### Testing language features

Ruby has a simple, declarative way of creating getters and setters, you don't need to test that:

    class User
      attr_accessor :name
    end

    class UserTest < Test::Unit::TestCase
  
      def test_should_be_able_to_set_name
        user = User.new
        user.name = 'Patrick'
        assert_equal 'Patrick', user.name
      end
  
    end

This just adds more tests to your suite for no value.  If one of these methods is overridden to provide additional functionality, it would then make sense to write a test for it.

### Multiple assertions per tests

This isn't a hard and fast rule, but you generally want to have a single assertion per test whenever possible (remember that mock expectations count as assertions).  It's sometimes more efficient to have multiple assertions in a test if your setup state is complicated, but there are a couple of issues that this exposes:

* Your code may need to be further modularized - that big setup could be a code smell telling you it's time to refactor
* Your test names quickly become ambiguous as to what they are actually testing

For example:

    class UserTest < Test::Unit::TestCase
  
      def test_valid
        user = User.new
    
        assert !user.valid?
    
        assert user.errors.on(:name)
        assert user.errors.on(:username)
      end
  
    end

A better approach would be to have 2 tests with descriptive names that test these conditions.  Since we're doing this in Ruby, the best approach would be to create some class-level macros to generate these boilerplate tests.

### Testing private methods

Private methods are often a product of a refactoring.  When you refactor during a test-first approach, you have already built up your regression tests.  Performing method extraction into a private method does not change the external behavior of the code under test, so you have no tests to add or change.

    class Line
  
      def initialize(content)
        @content = content
      end
  
      private
      def extract(pattern)
        @content.match(pattern)[1]
      end
  
    end

    class LineTest < Test::Unit::TestCase
  
      def test_extract_should_return_captured_value
        l = Line.new('This is content')
        assert_equal 'is', l.send(:extract, /(is)/)
      end
  
    end

Additionally, you're providing the `extract` method as part of the internal API for this class so any changes to it would now cause test breakage.  These private methods should be able to be changed without causing a ripple effect through your test suite.

### Setup state divorced from code under test

Understanding exactly what a test is doing is critical when familiarizing yourself with what a particular method does under certain conditions.  The more vertical scrolling you have to do to understand key pieces of setup state, the more context you lose around that test.  Refactoring your setup code is an important part of the test-first approach, but keep those pieces of information that matter in your test close to the actual code under test.

    class UserTest < Test::Unit::TestCase
  
      def setup
        @content = '{"user_name":"reagent","user_id":"12345"}'
      end
  
      def test_should_be_able_to_extract_the_username
        user = User.new(@content)
        assert_equal 'reagent', user.username
      end
  
      def test_should_be_able_to_extract_the_user_id
        user = User.new(@content)
        assert_equal '12345', user.id
      end
  
    end

### Testing only the happy path

As developers we tend to be optimists.  Testing the happy path is only part of the story, make sure that you test both branches in a conditional or provide input data that should cause problems:

    class User
  
      attr_writer :name
  
      def name
        @name.strip
      end
  
    end

    class UserTest < Test::Unit::TestCase
  
      def test_should_remove_whitespace_from_name
        user = User.new
        user.name = ' Patrick '
    
        assert_equal 'Patrick', user.name
      end
  
    end 

As you practice TDD, you can start modifying your approach to handle the cases where your code under test may fail.  Practicing this during a pair programming session (either driver/navigator or ping-pong) will help as well.

## Closing

Despite the debate that's going on right now, TDD is **not** a religion.  It's a tool that, if applied correctly to your development process, may allow you to better design and maintain your code. As with any new tool, feel free to remove it if it isn't working for you.

## Further Reading

* **[Test Driven Development: By Example](http://www.amazon.com/Test-Driven-Development-Kent-Beck/dp/0321146530/)** - Kent Beck
* **[Clean Code: A Handbook of Agile Software Craftmanship](http://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882/)** - Robert (Uncle Bob) Martin
* **[The Pragmatic Programmer: From Journeyman to Master](http://www.amazon.com/Pragmatic-Programmer-Journeyman-Master/dp/020161622X/)** - Andy Hunt & Dave Thomas
* **[Coders at Work](http://www.amazon.com/Coders-at-Work-Peter-Seibel/dp/1430219483/)** - Peter Siebel


