### HTML version of the C++ working paper

Complete unofficial, of course. Generated using the amazing [cxxdraft-htmlgen](https://github.com/Eelis/cxxdraft-htmlgen).

Currently four versions are available:

* Tip of trunk: [HTML](https://timsong-cpp.github.io/cppwp/) [Full PDF](https://timsong-cpp.github.io/cppwp/draft.pdf)
* N3337 (C++11 + editorial fixes): [HTML](https://timsong-cpp.github.io/cppwp/n3337/) [Full PDF](https://timsong-cpp.github.io/cppwp/n3337/draft.pdf)
* N4140 (C++14 + editorial fixes): [HTML](https://timsong-cpp.github.io/cppwp/n4140/) [Full PDF](https://timsong-cpp.github.io/cppwp/n4140/draft.pdf)
* N4618 (November 2016 post-Issaquah working draft): [HTML](https://timsong-cpp.github.io/cppwp/n4618/) [Full PDF](https://timsong-cpp.github.io/cppwp/n4618/draft.pdf)

I plan to generate (permanent) HTML versions for each post-meeting working draft after N4618.

#### A note on patches
I try to generate the HTML version from the LaTeX sources as-is, but sometimes things have to be changed.
- HTML versions of ToT and N4618 are generated after applying [a patch](https://github.com/timsong-cpp/cppwp/blob/master/htmlgen.patch)
to make the `<optional>` tables recognizable to cxxdraft-htmlgen. The PDF version is unaffected.
- N3337 and N4140 are generated after applying a few fixes: see the history of [my N3337 branch](https://github.com/timsong-cpp/draft/commits/n3337_fixed) and [N4140 branch](https://github.com/timsong-cpp/draft/commits/n4140_fixed).
