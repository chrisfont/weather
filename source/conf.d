module conf;

import std.json;
import std.conv;
import std.file;
import std.string;
import std.datetime;

class config
{
	static  string base_url = "https://api.forecast.io/forecast";
	private string api_key;
	private string location;

	private string config_filename;

	this()
	{
        // This is not a good way to initialize
	}

    this(string config_file)
    {
        config_filename = config_file;
    }

	public bool load()
	{
        bool loaded = false;
        
		if ( config_filename.length )
		{
            string config_doc = to!string(read(config_filename));
            
            if ( config_doc.length )
            {
                JSONValue json_doc = parseJSON(config_doc);
                api_key = json_doc.object["api_key"].str;
                location = json_doc.object["default_loc"].str;

                loaded = ( api_key.length ) ? true : false;
            }
		}

        return loaded;
	}

	public void set_api_key(string new_api_key)
	{
		api_key = new_api_key;
	}

	public void set_location(string new_location)
	{
		location = new_location;
	}

	public void set_location(double latitude, double longitude)
	{
		location = format("%d,%d", latitude, longitude);
	}

	public string get_url()
	{
		return format("%s/%s/%s", base_url, api_key, location);
	}

	public string get_url_now()
	{
		string time_now = Clock.currTime(UTC()).toSimpleString();

		return format("%s/%s/%s,%s", base_url, api_key, location, time_now);
	}
}
