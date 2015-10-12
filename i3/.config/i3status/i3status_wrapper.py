#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import Queue
import requests
import sys
import time
import threading

class MetarLoaderThread(threading.Thread):
    def __init__(self, freq, station, q):
        self.q = q
        self.freq = freq
        self.url = 'http://weather.noaa.gov/pub/data/observations/metar/stations/%s.TXT' % station.upper()
        super(MetarLoaderThread, self).__init__()

    def run(self):
        while True:
            r = requests.get(self.url)

            # first line contains date and time of issuance
            metar = r.text.strip().split('\n', 1)[-1]

            self.q.put(metar)

            time.sleep(self.freq)


def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing extra whitespace
    try:
        line = sys.stdin.readline().strip()

        # i3status sends EOF or empty line
        if not line:
            sys.exit(3)

        return line

    except KeyboardInterrupt:
        sys.exit()


def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()


if __name__ == '__main__':
    # skip first line with version_header
    print_line(read_line())

    # second line contains start of infinite array
    print_line(read_line())

    metar_q = Queue.Queue()
    metar_loader = MetarLoaderThread(300, 'kcll', metar_q)
    metar_loader.daemon = True
    metar_loader.start()

    metar = metar_q.get()

    while True:
        line, prefix = read_line(), ''

        # ignore comma at start of lines
        if line.startswith(','):
            line, prefix = line[1:], ','

        j = json.loads(line)

        # insert extra information
        if metar_q.full():
            metar = metar_q.get()
        j.insert(0, {'name': 'metar', 'instance': 'kcll', 'full_text': metar})

        # echo back new encoded json
        print_line(prefix + json.dumps(j))
