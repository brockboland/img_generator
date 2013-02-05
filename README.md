What
----
Generate every possible black-and-white image for a given set of dimensions.

Why
---
I got the idea from [a comment by Morinaka](http://www.reddit.com/r/programming/comments/171xod/the_joys_of_having_a_forever_project_whats_your/c81haai) on a [Reddit thread about "Forever Projects"](http://www.reddit.com/r/programming/comments/171xod/the_joys_of_having_a_forever_project_whats_your/). It was an interesting idea that kept bouncing around my mind, so a couple weeks later I took a stab at a crude version of it.

How
---
This script makes use of [`chunky_png`](https://github.com/wvanbergen/chunky_png) or [`oily_png`](https://github.com/wvanbergen/oily_png) by [Willem van Bergen](https://github.com/wvanbergen). `chunky_png` is a pure Ruby implementation; `oily_png` is a C implementation, so it's faster, but comes with a warning that it may gobble memory and cause problems.

You can install the gem by simply running `gem install chunky_png` or `gem install oily_png`; just make sure you use the corresponding `require` line in `generate.rb` for whichever gem you install.

To use the script, optionally set the `width` and `height` variables, then run `ruby generate.rb` from the command line. An `output` directory will be created, and PNG files will be saved there.

Keep in mind that increasing the values of `height` and `width` will quickly increase the run time of the script; the number of generated images is `2 ^ (height * width)`. Setting both to 4 will generate 65,536 images ( `2 ^ (4*4)` = `2 ^ 16` = 65,536). Setting the height and width to 6 and 8 (for wider images) will generate 281,474,976,710,656 images…which will take a while.

Benchmarks
==========
`oily_png` is a bit faster than `chunky_png`, and as it turns out, the [`rect` method](http://rdoc.info/gems/chunky_png/ChunkyPNG/Canvas/Drawing#rect-instance_method) is slower than manually coloring each pixel by looping to color in a larger area.

chunky_png
----------
With `rect` function
* 3x3, 10x scale: 1.234458 seconds
* 3x3, 40x scale: 12.044467 seconds

Manually coloring each pixel
* 3x3, 10x scale: 0.885919 seconds
* 3x3, 40x scale: 9.121357 seconds
* 3x3, 100x scale: 55.499981 seconds

oily_png
----------
[`oily_png`](https://github.com/wvanbergen/oily_png) offers marginal improvement over `chunky_png`, but manually drawing every pixel in each block is still faster than using the `rect` function.

With `rect` function
* 3x3, 10x scale: 1.235969 seconds
* 3x3, 40x scale: 12.260409 seconds
* 3x3, 100x scale: 71.492362 seconds

Manually coloring each pixel
* 3x3, 10x scale: 0.696371 seconds
* 3x3, 40x scale: 6.622205 seconds
* 3x3, 100x scale: 41.802607 seconds

Todo
====
- Rather than coloring `scale x scale` pixels for each block that needs to be black, generate the image at `width x height` pixels, then resize it to scale up.
  - https://github.com/sdsykes/fastimage_resize, requires gd
  - https://github.com/shokai/ImageResize-ruby, requires Java
- Avoid generating reflections? Maybe not worth it. Since it's only black and white, the only interesting output will be those that happen to generate shapes that are only recognizable in one direction, like letters or numbers.
- Improve speed
  - https://github.com/grosser/parallel