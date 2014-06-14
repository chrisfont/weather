import std.stdio;

import conf;

void main()
{
	config configuration = new config();

	configuration.set_location("37.8267,-122.423");
	configuration.set_api_key("");

	writeln("Config: ", configuration.get_url_now());

	getchar();
}