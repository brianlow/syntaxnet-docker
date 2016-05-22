[![Docker Pulls](https://img.shields.io/docker/pulls/brianlow/syntaxnet.svg?style=flat-square)](https://hub.docker.com/r/brianlow/syntaxnet/)
[![Docker Stars](https://img.shields.io/docker/stars/brianlow/syntaxnet.svg?style=flat-square)](https://hub.docker.com/r/brianlow/syntaxnet/)


Syntaxnet
=========

[Google's SyntaxNet](https://github.com/tensorflow/models/tree/master/syntaxnet) Parser and POS tagger.


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


Updating
--------

```
docker login
docker build -t brianlow/syntaxnet --no-cache . && docker push brianlow/syntaxnet

```

Last built from source May 22, 2016.
