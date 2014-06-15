import std.stdio;

import conf;

void main()
{
    config configuration = new config("config.json");

    if ( configuration.load() )
        writeln(configuration.get_url_now());
    else
        writeln("Failed to load configuration.");
}
