class Fluent::ParseRequestbodyInput < Fluent::TailInput
	Fluent::Plugin.register_input('parserequestbody', self)

	def configure_parser(conf)
		@time_format = conf['time_format'] || '%Y-%M-%d %H:%M:%S'
	end

  def parse_line(line)
  	elements = line.split("\t")
  	$stderr.puts elements

  	time = elements.shift
  	$stderr.puts time
  	time = Time.strptime(time, @time_format).to_i

    # [k1, v1, k2, v2, ...] -> {k1=>v1, k2=>v2, ...}
    record = {}
    while (k = elements.shift) && (v = elements.shift)
    	if(k =~ /request_body/)
    		$stderr.puts "found in K"
    		self.parseRequestBody(k, record)
    	elsif(v =~ /request_body/)
    		$stderr.puts "found in v"
    		self.parseRequestBody(j, record)
    	end

    	record[k] = v
    end

    $stderr.puts "**************"
    $stderr.puts record
    return time, record
  end

  protected
  def parseRequestBody(elements, record)

  	$stderr.puts "--------------"
  	$stderr.puts elements

  	$stderr.puts "++++++++++++++"
  	result = Hash[elements.split("\t").map{|f| f.split(":", 2)}]
  	result.each_key do |key|
  		$stderr.puts "#{key}"
  	end

  	result.each_value do |value|

  		$stderr.puts "@@@@@@@@@@@@@@"
  		$stderr.puts value

  		result2 = Hash[value.split(",").map{|f| f.split(":", 2)}]
  		$stderr.puts "%%%%%%%%%%%%%%"
  		$stderr.puts result2
  		result2.each do |key2, value2|
  			gsubKey = key2.gsub(/(\\x0A\\x22|\\x0A|\\x22|\{)/, "").strip
  			gsubValue = value2.gsub(/(\\x0A\\x22|\\x0A|\\x22|\{)/, "").strip
  			$stderr.puts "*************"
        $stderr.puts gsubKey
        $stderr.puts gsubValue
        record["#{gsubKey}" + ":" + "#{gsubValue}"] = ""
  		end
  	end
  end

  def format_log(message)
  	(@log_suffix and not @log_suffix.empty?) ? "#{message} #{@log_suffix}" : message
  end
end
