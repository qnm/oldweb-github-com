--- 
wordpress_id: 96
layout: article
title: Hacking Mediawiki
wordpress_url: http://www.sharp.id.au/?p=96
---
Mediawiki seems to be a great open-source project - it has a very large customer site (<a href="http://www.wikipedia.org">Wikipedia</a>), full time development and maintainence staff, yet still I struggled to find doco to enable me to customise it to my needs. I even got the standard RTFM from the IRC channel - great way to attract new developers, guys! All I wanted to do was update a wiki page from inside the application...

Contrast this to my experience customising Gallery2, which was a much bigger problem - synchronise changes to data across a group of servers - and I got loads of great help from the IRC channel. We ended up with a more pragmatic solution (running G2 on its own box), but it's good to know the support is there when you need it.

Anyway, for anyone who wants to know how to programatically update or append to a wiki page, here's whatI came up with:


<pre>$myNewContent = "Brillant!";</pre>

<pre>$articleName = "User_talk:" . $wgUser->getName(); // get the user talk page for the logged in user</pre>
<pre>$articleTitle = Title::newFromText($articleName); // create a wiki title name from the friendly name</pre>
<pre>$articleToUpdate = new Article ($articleTitle); // get an article instance</pre>

<pre>$currentContent = $articleToUpdate->getContentWithoutUsingSoManyDamnGlobals(); // i love comedy function names :-(
</pre>
<pre>$newContent = $currentContent . "\n" . $myNewContent; // create page content</pre>

<pre>$articleToUpdate->quickEdit( $newContent ); // update the article with the new content</pre>


Caveat Emptor - this doesn't take into account revisions, so you can't rollback a page after editing. I'm working on that though...
