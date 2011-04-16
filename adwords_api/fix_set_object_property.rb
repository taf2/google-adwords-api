# soap4r generates a set_object_property that doesn't camelize property values for Google from name_foo to nameFoo
# this script when run after rake will fix those methods, but updating each class to inherit from a base class and by 
# removing the repeated method

# first locate all the occurrences of set_object_property 
root_dir = File.expand_path(File.join(File.dirname(__FILE__)))
file_defs = `grep -rn set_object_property #{root_dir}/lib/adwords_api/v201101/ | grep def`.strip.split("\n").map do |m|
  file, line, match = m.split(':')
  {:file => file, :line => line}
end.reject{|fd|
  fd[:file] == File.join(root_dir,'lib/adwords_api/v201101/ServicedWrapperBase.rb')
}
# update each file
file_defs.each do|fd|
  lines = File.readlines fd[:file]
  line_start = fd[:line].to_i-1
  line_end   = fd[:line].to_i+10
  start = lines[line_start]
  if start.strip != 'def set_object_property(object, property, value)'
    raise "Something changed with the set_object_property in #{fd[:file]}"
  end
  finish = lines[line_end]
  if finish.strip != 'end'
    raise "Something changed with the set_object_property in #{fd[:file]}"
  end

  # chop out the function set_object_property
  lines.slice!(line_start..line_end)
  # locate the class declaration and add < ServerWrapperBase
  lines.unshift "require 'adwords_api/v201101/ServicedWrapperBase.rb'\n"
  lines.each_with_index do |line, number|
    if line.match(/^\s*class/) && line.match(/Wrapper$/)
      puts "found class on line: #{number} #{fd[:file]}"
      line.sub!(/Wrapper$/,"Wrapper < ServerWrapperBase\n")
    end
  end

  puts fd[:file]
  File.open(fd[:file],'wb') {|f| f << lines.join }
end
