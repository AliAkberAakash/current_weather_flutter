const jsonResponse = '''
{
  "cod": "200",
  "message": 0,
  "cnt": 40,
  "list": [
    {
      "dt": 1730548800,
      "main": {
        "temp": 284.24,
        "feels_like": 283.65,
        "temp_min": 283.81,
        "temp_max": 284.24,
        "pressure": 1030,
        "sea_level": 1030,
        "grnd_level": 985,
        "humidity": 86,
        "temp_kf": 0.43
      },
      "weather": [
        {
          "id": 804,
          "main": "Clouds",
          "description": "overcast clouds",
          "icon": "04d"
        }
      ],
      "clouds": {
        "all": 100
      },
      "wind": {
        "speed": 1.22,
        "deg": 74,
        "gust": 2.71
      },
      "visibility": 10000,
      "pop": 0,
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2024-11-02 12:00:00"
    }
  ],
  "city": {
    "id": 2838489,
    "name": "Schlimpfhof",
    "coord": {
      "lat": 50.2213,
      "lon": 9.9686
    },
    "country": "DE",
    "population": 0,
    "timezone": 3600,
    "sunrise": 1730527944,
    "sunset": 1730562893
  }
}
''';
