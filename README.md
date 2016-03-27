
active-perl Cookbook
==================

This cookbook will install active-perl to the next path: C:\Program Files as a default path in case of 64 bit and to the C:\Program Files (x86) in case of 32 bit
Default version installed is the latest version available.
Supported versions can be found at: [http://downloads.activestate.com/ActivePerl/releases/]
Supports: Windows 7, 8.0, 8.1, 10, 2008R2, 2012R2

Attributes
==================
#### active-perl::default

| Key | Type | Description | Default |
| --- | ---- | ----------- | ------- |
| ['active-perl']['version'] | String | application version | 'latest' |
| ['active-perl']['source'] | String | aplication source | nil |
| ['active-perl']['instPath'] | String | installation directory | nil |
| ['active-perl']['proxy'] | String | proxy | ' ' |
| ['active-perl']['envParam'] | String | environment parametr | 'Yes' | 

Usage
==================
#### 'active-perl'::default

Just include `active-perl` in your cookbook:

    include_recipe 'active-perl'

If you wish to install a specific version e.g: 5.22.1.2201

	{
	  "active-perl": {
		"version": "5.22.1.2201"
		}    
	}

If you wish to install a specific source please provide full link to the file source 

	{
	  "active-perl": {
		"source": "http://myftp/ActivePerl/ActivePerl-5.8.7.813-MSWin32-x86-148120.msi"
		}
	}

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Michael Vershinin

Support
-------------------
goldver@gmail.com