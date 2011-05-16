--- 
wordpress_id: 150
layout: article
title: Nice example of why we use FAIL testing in TDD
wordpress_url: http://www.sharp.id.au/nice-example-of-why-we-use-fail-testing-in-tdd/
---
<blockquote>
As I understood it, the first FAIL test ist NOT written to fail. It is just run on the code before checking the code that has to be tested in. This is to verify the test fails, if the new code that has to be tested is NOT implemented yet.

So an example. You want to add a banana (new code) to an application called fruit basket.

Right now the fruit basket has apples, pears and grapes in it.

The test you are running is a banana shaped stencil, through which you put every fruit.

The FAIL test now is run on the fruit basket WITHOUT having put the banana in yet. And surprise: It passes for grapes as well, because they are small enough to go through the stencil. Now we know that we have to adapt our test until it also fails for grapes or otherwise it will tell us nothing about bananas being correctly implemented into the fruit basket.

Only if we manage to design our testcase so it tells us "There is no banana in the fruitbasket" if there is really none there, we have a valid test. This first failure is as I understood it meant by the "Red" condition.
</blockquote>

Written by Dani, published on <a href="http://codebetter.com/blogs/scott.bellware/archive/2005/11/22/134954.aspx#161144">CodeBetter</a>.
