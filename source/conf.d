module conf;

import std.json;
import std.string;
import std.datetime;

class config
{
	static  string base_url = "https://api.forecast.io/forecast";
	private string api_key;
	private string location;

	private string config_file;

	this()
	{
	}

	public bool load()
	{
		if ( config_file.length )
		{

		}
		else
		{
			return false;
		}
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