SELECT 

CAST(date AS date) AS Date,
country,
capital,
CAST(lat AS FLOAT64) AS lat,
CAST(lon AS FLOAT64) AS lon,
CAST(temp_min_c AS FLOAT64) AS temp_min_c,
CAST(temp_max_c AS FLOAT64) AS temp_max_c,
CAST(temp_mean_c_approx AS FLOAT64) AS temp_mean_c_approx,
CAST(rain_mm AS FLOAT64) AS rain_mm,
CAST(snow_mm AS FLOAT64) AS snow_mm


FROM `weather-analytics-484616`.`weather_analytics`.`weather`