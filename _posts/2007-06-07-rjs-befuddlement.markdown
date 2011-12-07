--- 
wordpress_id: 147
layout: post
title: RJS befuddlement
wordpress_url: http://www.sharp.id.au/rjs-beffudlement/
---
I've been playing with Ruby on Rails lately, and, to be fair, there's a lot to love. As someone who codes in PHP for their day job, Rails provides me a wonderful example of how to do things properly. Everything feels nice, and many things are simple to implement, but for this little RJS problem I have is driving me crazy.

<strong>Why, oh, why do my RJS templates not always run as RJS when they should?
</strong>
I have an action method named test_attending, and an RJS template named test_attending.rjs. Everything works as you would expect - the action runs and the RJS template executes correctly. However, if I change the name of the method and template <strong>*in any way*</strong>, the whole thing fails to work. The controller looks to load attendin.rhtml, but that doesn't exist. Nightmare! I've even tried using the responds_to method, but to no avail. Why does changing the method name break everything?

As if to add insult to injury, it looks like I'm not able to run the UJS plugin either. Having installed the plugin and called the rake task, adding the UJS::routes method call to routes.rb causes what we in PHP land would call a Fat Al - a server 500.

I love Rails, and I'm finding it so easy to implement my new project in Rails that I wanna keep going, but these two little issues are dragging me down. What am I doing wrong, people?
