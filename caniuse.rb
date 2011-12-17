#!/usr/bin/env ruby 

require "rubygems"
require "bundler/setup"

# require your gems as usual
require "nokogiri"
require "open-uri"
require "json"
require "execjs"

caniuse_data_url = "http://caniuse.com/js.php" 
dir         = File.expand_path( File.dirname(__FILE__) )
cache_file  = File.join( dir, 'tmp', 'caniuse_cache_data' )


if !File.exists?( cache_file )
  File.open(cache_file, 'w') do |f|
    caniuse_page = open( caniuse_data_url ).read
    caniuse_data = caniuse_page.match(/caniuse.data=(\{.*?\});/m)[1]
    f.write caniuse_data
  end
end

caniuse_js_data = open(cache_file).read
caniuse = ExecJS.eval(caniuse_js_data)

caniuse.each do |key, data|
  next unless key.match(/^css/)
  stats = data["stats"]
  puts key
  puts "======"
  puts stats
end
