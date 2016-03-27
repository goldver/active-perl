#
# Cookbook Name:: active-perl
# Recipe:: default
#
# Copyright 2015, Michael Vershinin
#
# All rights reserved - Do Not Redistribute
#
ver = node['active-perl']['version']
install_directory = (node['active-perl']['instPath'].nil?)? '' : "TARGETDIR=#{node['active-perl']['instPath']}"

require "net/http"
require "uri"
proxy = URI.parse("#{node['active-perl']['proxy']}") 

if !node['active-perl']['source'].nil? 
	src = node['active-perl']['source']
	file = File.basename(src)
else
	if ver == 'latest'
		source = "http://www.activestate.com/activeperl/downloads"
	else
		source = "http://downloads.activestate.com/ActivePerl/releases/#{ver}/"	
	end

	uri = URI.parse("#{source}")
	http = Net::HTTP.new(uri.host,uri.port, proxy.host, proxy.port)
	response = http.request(Net::HTTP::Get.new(uri.request_uri))
	response.code
	if (response.code != "200")
		Chef::Log.error  "### Connection failed or your arguments aren't correct ###"
		return
	end
	body = response.read_body
	tmp = body.split("\n")	

	if ver == 'latest' 
		tmp = tmp.grep(/.msi/)[1]
		tmp = tmp.split("dl=")[1]
		# link to download a latest version
		downloadLink = tmp.split("\"  on")[0]
		file = downloadLink.split("\/")[-1]
	else
		# Checks OS type (64 or 32) and takes suitable file
		BitLevel = (node[:kernel][:machine] =~ /x86_64/) ? 64 : 86
		Chef::Log.info  "### The arch type is: #{BitLevel} ###"
		tmp = tmp.grep(/.msi/)

		if (BitLevel == 64)		
			os = tmp[0]
			os = os.split("f=\"")[1]
			file = os.split("\">A")[0]
		else
			os = tmp[1]
			os = os.split("f=\"")[1]
			file = os.split("\">A")[0]
		end
	end
end

fullVersion = file.split("l-")[1]
fullVersion = fullVersion.split("-M")[0]

splitver = fullVersion.split(".")
build = splitver[-1] # Return a Build number
curVersion = fullVersion.gsub(/.#{build}/, "") # Returns a version number without Build
Chef::Log.info  "### The Build is: #{build} ###"

displayVer = "#{splitver[0]}.#{splitver[1]}.#{build}"
Chef::Log.info  "### The displayVer is: #{displayVer} ###"

number = file.split(/-/)[-1]
number = number.split(/.msi/)[0] # Number before .msi
Chef::Log.info  "### The number before .msi is: #{number} ###"

arch = file.split("Win32-")[1] # Returns a values of OS type
arch = arch.gsub(/#{number}.msi/,"")
Chef::Log.info  "### The file relates to arch type: #{arch} ###"

name = "ActivePerl #{curVersion} Build #{build} (64-bit)"
FileName = "ActivePerl-#{fullVersion}-MSWin32-#{arch}#{number}.msi"

if !node['active-perl']['source'].nil? 
	name = name.gsub("(64-bit)", "") # The former format of exe-file was different (without "(64-bit)")
else
	src = "http://downloads.activestate.com/ActivePerl/releases/#{fullVersion}/#{file}"
end

Chef::Log.info "##### The version is: #{curVersion} ############"
Chef::Log.info "##### The full version is: #{fullVersion} ############"
Chef::Log.info "##### The source is: #{src} ############"
Chef::Log.info "##### The name is: #{name} ############"

# Installs package
windows_package name do
	source src
	installer_type :custom
	options "#{install_directory} PERL_PATH=\"#{node['active-perl']['envParam']}\" /q"
	version displayVer
	action :install
end

# Delete file from Chef cache 
cookbook_file "#{Chef::Config[:file_cache_path]}\\#{file}" do
	action :delete
end
