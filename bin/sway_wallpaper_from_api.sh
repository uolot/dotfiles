# API docs:
#   https://wall.alphacoders.com/api.php

API_KEY="$(cat "$HOME/.secrets/WALL_ALPHACODERS_API_KEY")"

# count
count=$(curl "https://wall.alphacoders.com/api2.0/get.php?auth=${API_KEY}&method=sub_category_count&id=168636" 2>/dev/null | jq '.count|tonumber')

pages=$((count / 30 + 1))

page=$((RANDOM % pages + 1))

echo "page $page / $pages"

# get, 30 results per page
image_url=$(
    curl "https://wall.alphacoders.com/api2.0/get.php?auth=${API_KEY}&method=sub_category&id=168636&page=${page}&info_level=2" 2>/dev/null |
        jq '.wallpapers[].url_image' |
        tr -d \" |
        shuf |
        head -1
)

echo "$image_url"

curl "$image_url" -o /tmp/wallpaper 2>/dev/null

exec sway output "*" background /tmp/wallpaper fill
