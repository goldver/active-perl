#[BASIC]
#Version installation required for active-perl.
#Accepted values: has to be a number or 'latest'. any valid version from: 
#http://downloads.activestate.com/ActivePerl/releases/
#The default value is: 'latest'
default['active-perl']['version'] = 'latest' 

#Source can be edit by user
#Default value is: nil
default['active-perl']['source'] = nil

#Installation Path
#Default value is: '%VENDOR_DRIVE%\\Vendor'
default['active-perl']['instPath'] = nil

#[ADVANCED]
#A proxy is basically another computer which serves as a hub through 
#which internet requests are processed
#The default value is: ' '
default['active-perl']['proxy'] = ' '

#Environment variables are a set of dynamic named values that can affect the way 
#running processes will behave on a computer
#The default value is: 'yes'
default['active-perl']['envParam'] = 'Yes' # This parameter is case sensitive

