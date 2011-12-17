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
  stats = data["stats"]
  puts key
  puts "======"
  puts stats
end
#  css                => caniuse
mapping= {
  "background-clip"   => "background-img-opts",
  "background-origin" => "background-img-opts",
  "background-size"   => "background-img-opts",
  "border-radius"     => "border-radius",
  "box-orient"        => "flexbox",
  "box-align"         => "flexbox",
  "box-flex"          => "flexbox",
  "box-flex-group"    => "flexbox",
  "box-ordinal-group" => "flexbox",
  "box-direction"     => "flexbox",
  "box-lines"         => "flexbox",
  "box-pack"          => "flexbox",
  "box-shadow"        => "css-boxshadow",
  "box-sizing"        => "css3-boxsizing",
  "column-count"      => "multicolumn",
  "column-gap"        => "multicolumn",
  "column-width"      => "multicolumn",
  "rule-width"        => "multicolumn",
  "rule-style"        => "multicolumn",
  "rule-color"        => "multicolumn",
  "column-rule"       => "multicolumn",
  "transition-property"  => "css-transitions",
  "transition-duration"  => "css-transitions",
  "transition-timing-function" => "css-transitions",
  "transition-delay" => "css-transitions",
  "transition"       => "css-transitions"
}

# TODO:
# Compass Images => SVG in CSS backgrounds
# Compass Transform => CSS3 Transforms 
# Compass Transform =>  CSS3 3D Transforms 
