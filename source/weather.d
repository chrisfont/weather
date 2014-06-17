/++
 + Weather module contains definitions for the Forecast.io API's data 
 + structures. The weather_api_c class acts as an interface between
 + Forecast.io's servers and the data structure you wish to populate.
 +
 + Authors: Chris Font
 + Date: June 18, 2014
 + History: Initial structures added. Some data manipulation code populated in
 +          weather_api_c
 + License: Apache License 2.0 (Apache-2.0)
 +
 +/
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

enum units_e
{ 
    us, 
    si, 
    ca, 
    uk, 
    auto_sel 
}

enum sources_e
{
    darksky,
    lamp,
    datapoint,
    metno,
    gfs,
    isd,
    nwspa,
    metwarn,
    cmc,
    fnmoc,
    naefs,
    nam,
    rap,
    metno_ce,
    metno_ne,
    metar,
    sref,
    rtma,
    madis
}

enum icon_e
{
    clear_day,
    clear_night,
    rain,
    snow,
    sleet,
    wind,
    fog,
    cloudy,
    partly_cloudy_day,
    partly_cloudy_night
}

// TODO Refactor this...it's messy
struct flags_t
{

    bool    darksky_unavailable;

    int[]   darksky_stations;
    int[]   datapoint_stations;
    int[]   isd_stations;
    int[]   lamp_stations;
    int[]   metar_stations;

    int     metno_license;

    int[]   sources;

    units_e units;
}

struct nearest_t
{
    double distance;
    double bearing;
}

struct precip_t
{
    enum precip_type_e { rain, snow, sleet, hail }

    double        intensity;
    double        intensity_error;
    double        intensity_max;

    double        probability;

    precip_type_e type;

    double        accumulation;
}

struct pressure_t
{
    double value;
    double error;
}

struct temp_t
{
    double value;

    double min;
    double min_time;

    double max;
    double max_time;
}

struct sun_t
{
    double rise;
    double set;
}

struct wind_t
{
    double speed;
    double speed_error;
    double bearing;
}


struct forecast_t
{
    double       latitude;
    double       longitude;

    double       time;
    double       offset;

    data_point_t currently;
    data_block_t minutely;
    data_block_t hourly;
    data_block_t daily;

    alert_t[]    alerts;
    flags_t      flags;
}

struct data_point_t
{
    double    time;
    string    summary;
    icon_e    icon;

    sun_t     sun;
    double    moon_phase;

    nearest_t nearest_storm;
    precip_t  precipitation;

    temp_t    temperature;
    temp_t    apparent_temperature;

    double    dew_point;
    wind_t    wind;
    double    cloud_cover;

    double    humidity;
    double    pressure;
    double    visibility;
    double    ozone;
}

struct data_block_t
{
    string         summary;
    icon_e         icon;

    data_point_t[] data;
}

struct alert_t
{
    string title;
    double expires;
    string description;
    string uri;
}
