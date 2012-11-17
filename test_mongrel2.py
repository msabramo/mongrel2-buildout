#!/usr/bin/env python

import unittest
import urllib2


class Mongrel2TestCase(unittest.TestCase):

    def test_simple(self):
        r = urllib2.urlopen('http://localhost:6767/')

        # import pdb; pdb.set_trace()
        # print(r)

        self.assertEqual(r.code, 200)
        self.assertEqual(r.headers['Server'], 'Mongrel2/1.7.5')
        self.assertEqual(r.read(), '<html>\n<h1>Hello world!</h1>\n</html>\n')


if __name__ == '__main__':
    unittest.main()
