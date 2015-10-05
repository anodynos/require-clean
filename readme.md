# require-clean v0.1.3

[![Build Status](https://travis-ci.org/anodynos/require-clean.svg?branch=master)](https://travis-ci.org/anodynos/require-clean)
[![Up to date Status](https://david-dm.org/anodynos/require-clean.png)](https://david-dm.org/anodynos/require-clean.png)

# Intro

Cleanly `require` a module from disk, having flushed the module's cache, including all of its submodules. Used like normal `require`.

# Installation

```
$ npm install require-clean --save
```

# Usage

In your code:

```
var requireClean = require('require-clean');
```

and then

## Clean module + submodules cache

```
var someMod = requireClean('../path/to/someMod');
```

or

```
requireClean.clean('../path/to/someMod');     // flush the cache for module + all submodules
var someMod = require('../path/to/someMod');  // normal require (but freshly read module + submodules)
```

## Clean module cache only, not submodules

If you want to delete ONLY the module and not its submodules, use :

```
var someMod = requireClean('../path/to/someMod', false);
```

or

```
requireClean.clean('../path/to/someMod', false);     // flush the cache for module ONLY
var someMod = require('../path/to/someMod');  // normal require (but freshly read module)
```

## Clean the whole nodejs modules cache

```
requireClean.clean()
```

# License

The MIT License

Copyright (c) 2014 Agelos Pikoulas (agelos.pikoulas@gmail.com)

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
