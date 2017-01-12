for f in src/*; do echo === $f === && diff -b ../system/$f.txt $f;done|less;
