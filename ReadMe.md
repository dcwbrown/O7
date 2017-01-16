# Oberon 07 experiments

Experiments with Niklaus Wirth's wonderfully concise language and operating system.

### Contents

&nbsp;&nbsp;&nbsp;&nbsp;[**Compiler**](#compiler)<br>
&nbsp;&nbsp;&nbsp;&nbsp;[**System**](#system)<br>
&nbsp;&nbsp;&nbsp;&nbsp;[**Status**](#status)<br>
&nbsp;&nbsp;&nbsp;&nbsp;[**License**](#license)<br>
&nbsp;&nbsp;&nbsp;&nbsp;[**Oberon**](#oberon)<br>
&nbsp;&nbsp;&nbsp;&nbsp;[**References**](#references)<br>


## Compiler

The compiler subdirectory builds a natively executable version of the Oberon-07 compiler using [Vishap Oberon](https://github.com/vishaps/voc).

This compiler can be built for Windows, Linux (inc Android) or BSD (inc Mac).

The compiler sources are changed very little to compile under the Oberon-2 compiler.


## System

The full Oberon-07 system is then built using the compiler above.


## Status

The result is currently a set of .rsc files containing RISC5 binaries. (Note, RISC5 is the RISC machine designed by Wirth as part of the Oberon project, and not the larger RISC-V open source risc architecture originated at the University of California, Berkeley.)


## License

The subdirectory 'wirth' is a snapshot of Oberon files published by Niklaus Wirth at [https://www.inf.ethz.ch/personal/wirth/](https://www.inf.ethz.ch/personal/wirth/) and is published with this license: [ProjectOberon/license.txt](wirth/ProjectOberon/license.txt).

Additions beyond the content of [https://www.inf.ethz.ch/personal/wirth/](https://www.inf.ethz.ch/personal/wirth/) are copyright (C) 2017 David CW Brown following the same license conditions: see [license.txt](LICENSE.txt).


## Oberon

Oberon is a programming language, an operating system and a graphical
user interface. Originally designed and implemented by by Niklaus Wirth and
Jürg Gutknecht at ETH Zürich in the late 1980s, it demonstrates that the
fundamentals of a modern OS and GUI can be implemented in clean and simple code
orders of magnitude smaller than found in contemporary systems.

The Oberon programming language is an evolution of the Pascal and Modula
languages. While it adds garbage collection, extensible types and (in
Oberon-2) type-bound procedures, it is also simplified following the principals
of Einstein and Antoine de Saint-Exupéry:

>  Make it as simple as possible, but not simpler. (Albert Einstein)

>  Perfection is finally attained not when there is no longer anything to add, but
>  when there is no longer anything to take away. (Antoine de Saint-Exupéry,
>  translated by Lewis Galantière.)


## References

###### Oberon
 - [The History of Modula-2 and Oberon](http://people.inf.ethz.ch/wirth/Articles/Modula-Oberon-June.pdf)
 - [The Programming Language Oberon](https://www.inf.ethz.ch/personal/wirth/Oberon/Oberon.Report.pdf)
 - [Project Oberon: The Design of an Operating System and Compiler ](http://www.ethoberon.ethz.ch/WirthPubl/ProjectOberon.pdf)
 - [Oberon - the Overlooked Jewel](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.90.7173&rep=rep1&type=pdf)

###### Oberon 2
 - [Differences between Oberon and Oberon-2](http://members.home.nl/jmr272/Oberon/Oberon2.Differences.pdf)
 - [The Programming Language Oberon-2](http://www.ssw.uni-linz.ac.at/Research/Papers/Oberon2.pdf)
 - [Programming in Oberon. Steps beyond Pascal and Modula](http://www.ethoberon.ethz.ch/WirthPubl/ProgInOberonWR.pdf)
 - [The Oakwood Guidelines for Oberon-2 Compiler Developers](http://www.math.bas.bg/bantchev/place/oberon/oakwood-guidelines.pdf)

###### Oberon 07
 - [Difference between Oberon-07 and Oberon](https://www.inf.ethz.ch/personal/wirth/Oberon/Oberon07.pdf)
 - [The Programming Language Oberon-07](https://www.inf.ethz.ch/personal/wirth/Oberon/Oberon07.Report.pdf)
 - [Programming in Oberon - a Tutorial](https://www.inf.ethz.ch/personal/wirth/Oberon/PIO.pdf)

###### Links
 - [Niklaus Wirth's personal page at ETH Zurich](https://www.inf.ethz.ch/personal/wirth/)
 - [ETH Zurich's Wirth publications page](http://www.ethoberon.ethz.ch/WirthPubl/)
 - [Joseph Templ's ofront on github](https://hithub.com/jtempl/ofront)
 - [Software Templ OG](http://www.software-templ.com)
 - [Oberon: Steps beyond Pascal and Modula](http://fruttenboel.verhoeven272.nl/Oberon/)

