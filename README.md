Generate every possible black-and-white image for a given set of dimensions.

I got the idea from [a comment by Morinaka](http://www.reddit.com/r/programming/comments/171xod/the_joys_of_having_a_forever_project_whats_your/c81haai) on a [Reddit thread about "Forever Projects"](http://www.reddit.com/r/programming/comments/171xod/the_joys_of_having_a_forever_project_whats_your/). It was an interesting idea that kept bouncing around my mind, so a couple weeks later I took a stab at a crude version of it.

This script makes use of [chunky_png](https://github.com/wvanbergen/chunky_png) by [Willem van Bergen](https://github.com/wvanbergen). You can install the gem by simply running `gem install chunky_png`.

To use the script, optionally set the `width` and `height` variables, then run `ruby generate.rb` from the command line. An `output` directory will be created, and PNG files will be saved there.

Keep in mind that increasing the values of `height` and `width` will quickly increase the run time of the script; the number of generated images is `2 ^ (height * width)`. Setting both to 4 will generate 65,536 images ( `2 ^ (4*4)` = `2 ^ 16` = 65,536). Setting the height and width to 6 and 8 (for wider images) will generate 281,474,976,710,656 images…which will take a while.