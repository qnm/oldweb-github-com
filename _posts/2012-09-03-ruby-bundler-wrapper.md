---
layout: post
title: "Fun with Bundler and RVM"
subtitle: "Eradicate /usr/bin/env: ruby_bundler_wrapper: No such file or directory"
name: ruby-bundler-wrapper
categories: ruby
created_at: 2012-09-03
updated_at: 2012-09-03

---
Fun with Bundler and RVM: /usr/bin/env: ruby_bundler_wrapper: No such file or directory
=====

Recently I began working on an old 3.0-era app, which is a long time ago in Ruby terms.

This used bundler 1.0.7, which is even longer ago in Bundler terms.

When I switched back to my day-job 3.1 app, I started seeing the following error:

    /usr/bin/env: ruby_bundler_wrapper: No such file or directory

A quick check on freenode#rvm reveals that older bunder versions mangle .gemrc with a custom_shebang directive.

After removing custom_shebang from .gemrc, all is well with the world.

Hopefully this post will help someone else fix the issue when it rears its head again.
