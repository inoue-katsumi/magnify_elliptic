# magnify_elliptic

magnify_elliptic uses Imagemagick to magnify part of the image and writes out to a new file.
It crops out circle or elliptic area so it produces an image as if magnifying-glass(loupe) were used.

## Usage:

```bash
magnify_elliptic.sh center_x,center_y left_x_coord top_y_coord magnify_ratio input_file output_file
```

## magnify_elliptic.sh:

Invokes Imagemagick convert many times. Writes intermediary images to /tmp/ which would be of use, too.
