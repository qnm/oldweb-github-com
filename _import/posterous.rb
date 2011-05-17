require 'rubygems'
require 'hpricot'
require 'fileutils'
require 'open-uri'

module Jekyll
  module Posterous
    def self.process(hostname,page=1)
      FileUtils.mkdir_p "_posts"

      while doc = posts(hostname, page)
        posts = extract(doc)

        posts.each do |post|
          filename = save(post)
          puts "Post #{filename} ingested"
        end

        puts "Page #{page} ingested"
        page += 1
      end

    end

    def self.posts(hostname, page)
      uri = URI.parse("http://posterous.com/api/readposts?hostname=#{hostname}&num_posts=50&page=#{page}")
      begin
        doc = Hpricot::XML(uri.read)
      rescue ENETUNREACH
        puts 'The Posterous importer needs an internet connection'
      end

      ((doc/:post).count == 0) ? false : doc
    end

    def self.extract(doc)
			(doc/:post).collect do |item|
        post = {}
				post[:title] = item.at(:title).inner_text
				post[:date] = item.at(:date).inner_text
        post[:body] = item.at('body').inner_text
        post
			end
    end

    def self.save(post)
      filename = "#{Date.parse(post[:date]).to_s}-#{post[:title].gsub(/[^[:alnum:]]+/, '-').downcase}.html"
      File.open("_posts/#{filename}", "w") do |f|
        f.puts <<-HEADER
---
layout: article
title: #{post[:title]}
created_at: #{post[:date]}
---
#{post[:body]} 
HEADER
      end
      filename
    end
  end
end
