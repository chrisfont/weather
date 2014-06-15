module weather;

import conf;

import std.json;
import std.conv;
import std.container;
import std.net.curl;

class WeatherAPI
{
	private config configuration;

	this(config new_config)
	{
        // This assumes a proper configuration is passed in at initialization
        configuration = new_config;
        
        // NOTE We could check initialization status here and deconstruct immediately
	}

    public void get_weather_now()
    {
        string request = to!string(get(configuration.get_url_now()));

        JSONValue json = parseJSON(request);
    }
}

// TODO Add class for each data collection
class Weather
{
}

class WeatherMinutely
{
    private SList!Precipitation precip;

    this()
    {
    }
}

class Precipitation
{
    private uint time;
    private uint intensity;
    private uint probability;

    this(uint new_time, uint new_intensity, uint new_probability)
    {
        time        = new_time;
        intensity   = new_intensity;
        probability = new_probability;
    }
}
