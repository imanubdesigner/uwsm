#!/usr/bin/env python3

#    ┓ ┏┏┓┏┓┏┳┓┓┏┏┓┳┓ ┏┓┓┏
#    ┃┃┃┣ ┣┫ ┃ ┣┫┣ ┣┫ ┃┃┗┫
#    ┗┻┛┗┛┛┗ ┻ ┛┗┗┛┛┗•┣┛┗┛
#                  by Manu

import time
import requests
import json
import os
import logging
import re
from pyquery import PyQuery  # install using `pip install pyquery`

# === WAIT before starting ===
time.sleep(3)  # Wait 3 seconds before running the script to prevent startup issues

# === LOGGING CONFIGURATION ===
log_path = os.path.expanduser("~/.cache/weather_error.log")
logging.basicConfig(filename=log_path, level=logging.DEBUG)

# === WEATHER ICONS ===
weather_icons = {
    "sunnyDay": "󰖙",
    "clearNight": "󰖔",
    "cloudyFoggyDay": "",
    "cloudyFoggyNight": "",
    "rainyDay": "",
    "rainyNight": "",
    "snowyIcyDay": "",
    "snowyIcyNight": "",
    "severe": "",
    "default": "",
}

# === GET LOCATION WITH RETRIES ===
def get_location(retries=3, delay=2):
    for i in range(retries):
        try:
            response = requests.get("https://ipinfo.io", timeout=5)
            data = response.json()
            loc = data["loc"].split(",")
            return float(loc[0]), float(loc[1])
        except Exception as e:
            logging.warning(f"[get_location] Attempt {i+1} failed: {e}")
            time.sleep(delay)
    raise RuntimeError("Failed to get location after retries")

# === MAIN EXECUTION ===
try:
    # Get latitude and longitude
    latitude, longitude = get_location()

    # Build weather.com URL
    url = f"https://weather.com/en-PH/weather/today/l/{latitude},{longitude}"

    # Load HTML
    html_data = PyQuery(url=url)

    # Current temperature
    temp = html_data("span[data-testid='TemperatureValue']").eq(0).text()

    # Current weather status
    status = html_data("div[data-testid='wxPhrase']").text()
    status = f"{status[:16]}.." if len(status) > 17 else status

    # Status code for icon
    status_code = html_data("#regionHeader").attr("class").split(" ")[1].split("-")[0]
    icon = weather_icons.get(status_code, weather_icons["default"])

    # Feels like
    temp_feel = html_data(
        "div[data-testid='FeelsLikeSection'] > span > span[data-testid='TemperatureValue']"
    ).text()
    temp_feel_text = f"Feels like {temp_feel}c"

    # Min/max temperature
    temp_min = (
        html_data("div[data-testid='wxData'] > span[data-testid='TemperatureValue']")
        .eq(1)
        .text()
    )
    temp_max = (
        html_data("div[data-testid='wxData'] > span[data-testid='TemperatureValue']")
        .eq(0)
        .text()
    )

    # Wind, humidity, visibility, AQI
    wind_speed = html_data("span[data-testid='Wind'] > span").text()
    wind_text = f"  {wind_speed}"

    humidity = html_data("span[data-testid='PercentageValue']").text()
    humidity_text = f"  {humidity}"

    visibility = html_data("span[data-testid='VisibilityValue']").text()
    visibility_text = f"  {visibility}"

    air_quality_index = html_data("text[data-testid='DonutChartValue']").text()

    # Hourly rain prediction – formatted
    try:
        rain_elements = html_data("div[data-testid='SegmentPrecipPercentage'] > span")
        prediction_lines = []

        for el in rain_elements.items():
            text = el.text().strip()
            if not text:
                continue

            match = re.search(r"(\d+)\s*%", text)
            if match:
                percentage = match.group(1)
                prediction_lines.append(f"Chance of Rain {percentage}%")
            else:
                logging.debug(f"[rain debug] Ignored rain text: '{text}'")

        if prediction_lines:
            predictions = "\n".join(prediction_lines)
            predictions = f"\n<big> </big> Hourly rain:\n{predictions}"
        else:
            predictions = ""

    except Exception as e:
        logging.error(f"[rain error] Failed to parse rain predictions: {e}")
        predictions = ""

    # Tooltip (multi-line info for hover)
    tooltip_text = f"""
<span size="xx-large" weight="bold">{temp}</span>

<small>{temp_feel_text}</small>
<big>{icon}</big>  <b>{status}</b>

  {temp_min}        {temp_max}

 {wind_speed}      {humidity}
  {visibility}  AQI {air_quality_index}

{predictions}
"""

    # Output for Waybar
    out_data = {
        "text": f"{icon}  {temp}",
        "alt": status,
        "tooltip": tooltip_text,
        "class": status_code,
    }
    print(json.dumps(out_data))

    # Write to simple cache
    simple_weather = (
        f"{icon}  {status}\n"
        + f"  {temp} ({temp_feel_text})\n"
        + f"{wind_text} \n"
        + f"{humidity_text} \n"
        + f"{visibility_text} AQI{air_quality_index}\n"
    )

    try:
        with open(os.path.expanduser("~/.cache/.weather_cache"), "w") as file:
            file.write(simple_weather)
    except Exception as e:
        logging.error(f"Error writing to cache: {e}")

# Error fallback
except RuntimeError as e:
    logging.error(f"Weather script failed: {e}")
    print('{"text": "", "tooltip": "Network unavailable"}')

except Exception as e:
    logging.error(f"Unexpected error:\n{e}")
    print('{"text": "", "tooltip": "Weather error"}')

