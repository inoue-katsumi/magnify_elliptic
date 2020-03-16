# magnify_elliptic

magnify_elliptic uses Imagemagick to magnify part of the image and writes out to a new file.
It crops out circle or elliptic area so it produces an image as if magnifying-glass(loupe) were used.
Sample output can be found at https://katsumiinoue.wordpress.com/2020/03/16/%e7%94%bb%e5%83%8f%e4%b8%b8%e6%8a%9c%e3%81%8d%e6%8b%a1%e5%a4%a7imagemagick%e3%82%b9%e3%82%af%e3%83%aa%e3%83%97%e3%83%88/

## Usage:

```bash
magnify_elliptic.sh center_x,center_y left_x_coord top_y_coord magnify_ratio input_file output_file
```

## magnify_elliptic.sh:

Invokes Imagemagick convert many times. Writes intermediary images to /tmp/ which would be of use, too.
