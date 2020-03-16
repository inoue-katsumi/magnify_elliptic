#!/usr/bin/env bash
# Usage: center-x,center-y left-x top-y zoom_ratio input-filename output-filename
# Recommended zoom_ratio is somewhere between 130 and 150
c_x=${1%,*}
c_y=${1#*,}
left_x=$2
top_y=$3
zoom_ratio=$4
r_x=$((c_x-left_x))
r_y=$((c_y-top_y))

# Resize whole image and crop out the area.
convert $5 -resize ${zoom_ratio}% -alpha on -background none \
	\( +clone -channel a -evaluate multiply 0 +channel -fill white -draw \
	"ellipse $((c_x*zoom_ratio/100)),$((c_y*zoom_ratio/100)) $((r_x*zoom_ratio/100)),$((r_y*zoom_ratio/100)) 0,360" \) \
	-compose DstIn -composite /tmp/_$$_inside_magnifier.png
#
# Create elliptic image on which to place the zoomed image later.
#   TODO: "12" is currently hard-coded because I'm not sure what this exactly is.
#   TODO: Make border slightly transparent, currently it's just a grey shade.
#
convert -size $(((r_x+c_x)*zoom_ratio/100+12))x$(((r_y+c_y)*zoom_ratio/100+12)) xc:black -fill white -draw \
	"ellipse $((c_x*zoom_ratio/100)),$((c_y*zoom_ratio/100)) $((r_x*zoom_ratio/100+12)),$((r_y*zoom_ratio/100+12)) 0,360" \
	\( -clone 0 -virtual-pixel black -blur 0x16 -level 4x100% -opaque transparent \) +swap -alpha off \
	-compose copy_opacity -composite /tmp/_$$_shaded_elliptic.png
#
# Overlay these 2 files and crop
#
convert /tmp/_$$_shaded_elliptic.png /tmp/_$$_inside_magnifier.png -composite /tmp/_$$_zoomed_cropped_magnifier.png
#
# Overlay on to original image
#
convert $5  /tmp/_$$_zoomed_cropped_magnifier.png -geometry $((c_x-(c_x*zoom_ratio/100)))$((c_y-(c_y*zoom_ratio/100))) -composite $6
