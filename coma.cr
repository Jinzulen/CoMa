# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2022 Khalil G. <https://github.com/Jinzulen>

require "crystagiri"
require "http/client"
require "option_parser"

# Version
VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}

OptionParser.parse do |parser|
	# Help dialog.
	parser.on "-h", "--help", "Show the help dialog." do
		puts parser
		exit(1)
	end

	# Show version.
	parser.on "-v", "--version", "Show program version." do
		puts "# CoMa v#{VERSION}"
		puts "# Check for an updated version over @ https://github.com/Jinzulen/CoMa"
		exit(1)
	end

	# Grab the latest statistics.
	parser.on "-g", "--get", "Grab the latest statistics." do
		# Header
		puts "# CoMa v#{VERSION} by Jinzulen."
		puts "# Licensed under Apache 2.0"
		puts "# Copyright (C) 2022 Khalil G.\n\n"

		begin
			# Gateway.
			request_gateway : String = "http://www.covidmaroc.ma/Pages/Accueilfr.aspx"
			
			# Headers.
			request_headers = HTTP::Headers {
				"User-Agent" => "Jinzulen/CoMa"
			}

			# Send GET request.
			HTTP::Client.get(request_gateway, headers: request_headers) do |res|
				# Handle an erroneous request.
				if !res.success?
					STDERR.puts "# [COMA] <#{res.status_code}> #{res.status_message}"
					exit(1)
				else
					# Start scraping.
					res_html = res.body_io.gets_to_end
					res_docu = Crystagiri::HTML.new res_html

					# Data stores.
					fin_store = Array(String).new
					res_store = Array(String).new

					# Labels store.
					res_labels = [
						"Tests",
						"Confirmed",
						"Recovered",
						"Deceased",
						"Dose #1",
						"Dose #2",
						"Dose #3",
					]

					# Grab the data.
					res_docu.where_tag("tr > td > p > span") do |b|
						# Get rid of white space.
						["\u0020", "\u200B", "\u00A0"].each do |o|
							b.node.content = b.node.content.gsub(o, "")
						end

						# Push the content of the individual nodes
						# into the temp. store.
						res_store.push(b.node.content)
					end

					# Process the data.
					res_store.delete_at(0)

					res_store.each do |t|
						if t.size > 1
							# Format.
							t = t.to_i.format(".", ",")
							
							# Push.
							fin_store.push(t)
						end
					end
					
					# Publish the data.
					fin_store.each_index do |n|
						puts "# [COMA: Statistics] #{res_labels[n]}: #{fin_store[n]}"
					end
				end
			end
		rescue ex
			STDERR.puts ex.message
			exit(1)
		end
	end

	# Errors.
	parser.invalid_option do |f|
		STDERR.puts "# [COMA] <#{f}> is not a recognized flag."
		exit(1)
	end
end
