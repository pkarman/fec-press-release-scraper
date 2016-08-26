#!/usr/bin/env python3

# include local python rest client lib
# not assuming this is installed already
# but might be in parallel dir (as it is for me)
import sys
from TAP.Simple import *
from subprocess import Popen, PIPE
import json

script = './fec-press-release-scraper'

def parse_url(url):
  process = Popen([script, url], stdout=PIPE)
  (output, err) = process.communicate()
  #print(output.decode('utf-8'))
  exit_code = process.wait()
  if exit_code != 0:
    print("%s failed: %s" % (url, err))
    return
  else:
    return json.loads(output.decode('utf-8').rstrip())

urls = [
  'press2012/20120524openmeeting.shtml'
]

plan(len(urls)*3)

for url in urls:
  parsed = parse_url(url)
  ok(parsed, "parsed {0}".format(url))
  
  ok(parsed['pdf'], "got pdf")
  ok(parsed['html'], "got html")
  #diag(parsed['html'])
