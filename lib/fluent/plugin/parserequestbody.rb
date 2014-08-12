require "fluent/plugin/parserequestbody/version"

module Fluent
	module Plugin
    #module Parserequestbody
    class ParseRequestbodyOutput < Fluent::Output
    	Fluent::Plugin.register_output('parserequestbody', self)

    	def emit(tag, es, chain)
    		es.each {|time,record|
    			chain.next
    			bucket = {@json_key => record.to_json}
    			Fluent::Engine.emit(@output_tag, time, bucket)
    		}
    	end
    end
  end
end
