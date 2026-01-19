SELECT 
date,
country,
capital,
lat,
lon,
temp_min_c,
temp_max_c,
temp_mean_c_approx,
rain_mm,
snow_mm
FROM {{ ref('stg_weather') }}