require "minitest/autorun"
$LOAD_PATH << File.dirname(__FILE__) + "/../lib"

Dir["spec/**_spec.rb"].each do |spec|
  require "./#{spec}"
end
