class Fluent::ParseRequestbodyInput < Fluent::TailInput
	Fluent::Plugin.register_input('parserequestbody', self)

	def configure_parser(conf)
		@time_format = conf['time_format'] || '%Y-%M-%d %H:%M:%S'
	end

  def parse_line(line)
  	elements = line.split("\t")

  	time = elements.shift
    time_local = time # We need raw time_local data
  	time = Time.strptime(time, @time_format).to_i

    record = {}
    record["time_local"] = time_local
    while (k = elements.shift) && (v = elements.shift)
    	if(k =~ /request_body/)
    		self.parseRequestBody(k, record)
    	elsif(v =~ /request_body/)
    		self.parseRequestBody(j, record)
    	end

      kVal = k.split(":")
    	record[kVal[0]] = kVal[1]

      vVal = v.split(":")
    	record[vVal[0]] = vVal[1]
    end

    $stderr.puts record
    return time, record
  end

  protected
  def parseRequestBody(elements, record)
  	result = Hash[elements.split("\t").map{|f| f.split(":", 2)}]
  	result.each_key do |key|
  		$stderr.puts "#{key}"
  	end

  	result.each_value do |value|
  		result2 = Hash[value.split(",").map{|f| f.split(":", 2)}]
  		result2.each do |key2, value2|
  			gsubKey = key2.gsub(/(\\x0A\\x22|\\x0A|\\x22|\{)/, "").strip
  			gsubValue = value2.gsub(/(\\x0A\\x22|\\x0A|\\x22|\{)/, "").strip
        record[gsubKey] = gsubValue
  		end
  	end
  end

  def format_log(message)
  	(@log_suffix and not @log_suffix.empty?) ? "#{message} #{@log_suffix}" : message
  end
end
