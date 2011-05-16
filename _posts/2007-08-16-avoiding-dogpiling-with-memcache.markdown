--- 
wordpress_id: 153
layout: post
title: Avoiding Dogpiling with Memcache
wordpress_url: http://www.sharp.id.au/avoiding-dogpiling-with-memcache/
---
<p>To be honest, I've only heard the term 'Dogpiling' in this context once before - it makes me think of a search engine I used many moons ago. Anyway, dogpiling is the messy situation you end up in when your cache expires and the time it takes for the cache  rebuilt takes longer to generate than your server is answering requests per second.</p>

<p>Being a content-driven site with up-to-date information, we keep our cache expiry times reasonably short, but in peak periods we service a lot of customers. So how do you avoid dogpiling? Since we used a memcache wrapper (a PEAR_Cache implementation actually - if you're interested I can send you the code) it's quite easy for add a few extra checks to ensure it doesn't happen.</p>

<p>The concept is reasonably simple - use a 'stale' timestamp in addition to your memcache expiry date, perhaps a minute less than the expiry time, and store this somewhere. When you retrieve your data, if now() is past this 'stale' timestamp, go and get your data but then set this stale date to now() + expiry - staletime (1 min). This has the effect of (hopefully) only building data once, whilst all subsequent requests are served old data until the build is complete.I'll post some code here shortly...</p>
