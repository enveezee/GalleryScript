#!/bin/bash

[ ! $title ] && title="Image Gallery"
[ ! $header ] && header="Image Gallery"
[ ! $subheader ] && subheader="click on image to see full size"
[ ! $footer ] && footer="Image gallery auto-generated"

read -r -d '' head << EOM
<!DOCTYPE html>
<html>
 <head>
  <title>$title</title>
  <link rel="stylesheet" href="gallery.css">
 </head>
 <body>
  <h2>$header</h2>
  <h4>$subheader</h4>
EOM

read -r -d '' foot << EOM
  <div class="clearfix"></div>

  <div style="padding:6px;">
   <p>$footer</p>
  </div>
 </body>
</html>
EOM

mkdir thumbnails

shopt -s nocaseglob nullglob

echo "$head" > index.html

for img in *.gif *.jpg *.jpeg *.png

mogrify -resize 600x400! "$img" "thumbnails/$img"

do read -r -d '' body << EOM
<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="$img">
      <img src="thumbnails/$img" width="600" height="400">
    </a>
    <div class="desc">$img</div>
  </div>
</div>
EOM

 echo "$body" >> index.html

done

echo "$foot" >> index.html

