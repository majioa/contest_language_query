# Test for Ruby on Rails Developer applicants

## Ruby on Rails Developer Applicants Test

To understand your coding ability and style, we have devised a simple practical coding test.
		
We use this as a dicussion topic during interviews and may use it as a sample of your knowledge when presenting your profile to customers.

### Objective:
			
* Make [this data](db/seeds/data.json) searchable

### Bare minimum requirements:

* Implementation must use Ruby on Rails, JavaScript and HTML (all three)
* Search logic should be implemented in Ruby and written by YOU, don't use a gem or external code for this
* A search for `Lisp Common` should match a programming language named "Common Lisp"
* Your solution will be tested on a Mac running OS X El Capitan, **Ruby 2.2.3** and Rails 4.2.4
* Deliver your solution as a zip or tar.gz file
* We will unpack your solution and run it locally

### Meriting (needed for full score):

* Writing code with reusability in mind
* Search match precision
* Search results ordered by relevance
* Support for exact matches, eg. `Interpreted "Thomas Eugene"`, which should match "BASIC", but not "Haskell";
* Match in different fields, eg. `Scripting Microsoft` should return all scripting languages designed by "Microsoft";
* Support for negative searches, eg. `john -array`, which should match "BASIC", "Haskell", "Lisp" and "S-Lang", but not "Chapel", "Fortran" or "S".
* Solution elegance
* Visual design

### Keep in mind:

* Frameworks are allowed (Rails of course is needed), but not required.
* If you use a framework, please do not include the framework code. Write instructions allowing us to install the framework by ourselves (and where to add your code).
* Comments are VERY useful, they help us understand your thought process
* This exercise is **not** meant to take more than **4 - 6 hours**
* A readme file is highly encouraged
* It's preferable if you don't use a database for this small data set, instead read the JSON file
