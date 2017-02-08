#!/usr/bin/env node

require('coffee-script/register');

var fs = require('fs');
var path = require('path');
var lib  = path.join(path.dirname(fs.realpathSync(__filename)), '../lib');

require(path.join(lib,'merger'));
