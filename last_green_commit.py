#!/usr/bin/env python
import sys
import json
try:
    from urllib.request import urlopen
except ImportError:
    from urllib2 import urlopen


url = sys.argv[1]
data = json.load(urlopen(url))
print(data[0]['sha'])
