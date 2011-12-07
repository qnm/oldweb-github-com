--- 
wordpress_id: 151
layout: post
title: Mock Chop using PHP and Simpletest
excerpt: |
  One of my reservations about adopting Unit Testing as a standard for my team was that, despite being pretty good developers, a fair amount of our code ends up being coupled.
  
  Here's how I managed to avoid coupling whilst unit testing.

wordpress_url: http://www.sharp.id.au/mock-chop-using-php-and-simpletest/
---
One of my reservations about adopting Unit Testing as a standard for my team was that, despite being pretty good developers, a fair amount of our code ends up being coupled.

Recently I decided to dive in head-first to <a href="http://en.wikipedia.org/wiki/Test-driven_development">Test Driven Development</a> (TDD to his friends) to see if building a greenfield project test-first would alleviate our tendency to couple code. Our shop develops in PHP, so the <a href="http://www.lastcraft.com/simple_test.php">Simpletest</a> library was chosen to provide a Unit Test framework.

Another developer and I sat down and coded the first few requirements of this new project, and successfully created a number of methods that could be unit-tested without requiring to be coupled to any other classes.

The problem arose when implementing a facade. The method we' d written looked a little like this:

<pre>class Actionable_JoinGroup
{
	
	function execute()
	{
		// do stuff to allow user to join group
		return GroupHelper::JoinGroup($this-&gt;_userId, $this-&gt;_groupId);
	}

}
</pre>As you can see, we've coupled the GroupHelper with the containing class, making it impossible to test the execute method without also invoking the JoinGroup method of the GroupHelper class. This is perfectly acceptable outside of testing, but causes no end of issues when outside classes are called from within unit tests. This can be avoided using by <a href="http://www.lastcraft.com/mock_objects_documentation.php">Mock Objects</a>:

<pre>Mock::Generate('GroupHelper');
$mockClass = new MockGroupHelper();
</pre>You can then call execute() on $mockClass without invoking the real method, but that still leaves the issue of coupling our abstraction with our helper.
My solution was to create a member variable instance of the helper class and call it instead. We can use the constructor to populate the member variable with the required helper:

<pre>class Actionable_JoinGroup
{
	var $_helper;
	
	function Actionable_JoinGroup()
	{
		// set a member variable to helper instance
		$this-&gt;_helper = new GroupHelper();
	}
	
	function execute()
	{
		// do stuff to allow user to join group
		return $this-&gt;_helper-&gt;JoinGroup($this-&gt;_userId, $this-&gt;_groupId);
	}

}
</pre>We can now inject our mock instance into the member variable inside unit tests, and check that all calls are made correctly without actually calling a method in an outside class:

<pre>class Actionable_JoinGroupTest extends UnitTest
{
	function testJoinGroup()
	{
		$wrapperClass = new Actionable_JoinGroup();
		
		// generate a mock to allow calling of helpers
		// without actually executing code
		Mock::generate('GroupHelper');
		
		// inject a mock instance
		$wrapperClass-&gt;_helper = new MockGroupHelper();

		// set up your expectations here

		// ...and execute!
		$resultSet = $wrapperClass-&gt;execute();
	}
}
</pre>Discovering this concept has helped clear up many issues for me, and hopefully it'll help some else to become 'test-infected'.
