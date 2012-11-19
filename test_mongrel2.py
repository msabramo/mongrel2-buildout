#!/usr/bin/env python

import unittest

try:
    # Python 2
    from urllib2 import urlopen
except ImportError:
    from urllib.request import urlopen


class Mongrel2TestCase(unittest.TestCase):

    def test_simple(self):
        resp = urlopen('http://localhost:6767/tests/')

        self.assertEqual(resp.code, 200)
        self.assertEqual(resp.headers['Server'], 'Mongrel2/1.8.0')
        self.assertEqual(resp.read().decode('utf-8'), '<html>\n<h1>Hello world!</h1>\n</html>\n')

        resp.close()


if __name__ == '__main__':
    unittest.main()
