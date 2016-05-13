Syntaxnet
=========

Dockerized version of [Google's SyntaxNet](https://github.com/tensorflow/models/tree/master/syntaxnet) Parser and POS tagger.


Usage
-----

```shell
echo "Name this boat" | docker run --rm -i brianlow/syntaxnet
...
Input: Name this boat
Parse:
Name VB ROOT
 +-- boat NN dobj
     +-- this DT det
```
