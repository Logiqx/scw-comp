#!/usr/bin/env python
# coding: utf-8

# # Senior Cubers Worldwide - Weekly Competition
# 
# Created by Michael George (AKA Logiqx)
# 
# Website: https://logiqx.github.io/scw-comp/

# In[1]:


import unittest


# ## Formatting Functions
# 
# Functions to convert results to and from seconds or display an age category

# In[2]:


import re
import math

resultPattern = re.compile('^([1-7][0-9]|80)$|^([0-5]?[0-9]:[0-5]|[0-5])?[0-9]\.[0-9][0-9]$|^DNF$|^DNS$')

def numSeconds(value):
    '''Convert float or string to number of seconds (truncated to nearest 100th) - e.g. 1:05.319 returns 65.31'''
    
    # String result (e.g. MM:SS.cc, SS.cc, nn, DNF or DNS)
    if isinstance(value, str):
        try:
            # Some people may have used commas instead of dots
            value = value.replace(',', '.')

            # Check that the result is either a time, DNF or DNS
            if not resultPattern.match(value):
                raise ValueError(value, type(value))

            # MM:SS.cc
            if ':' in value:
                parts = value.split(':')
                value = int(parts[0]) * 60 + float(parts[1])
            # SS.cc
            elif '.' in value:
                value = float(value)
            # DNF
            elif value == 'DNF':
                return -1
            # DNS
            elif value == 'DNS':
                return -2
            # Assume nn - i.e. FMC
            else:
                return int(value)
        except:
            raise
    
    # Convoluted approach is required to handle imprecision of floating point arithmetic
    return math.trunc(round(value * 1000) / 10) / 100


# In[3]:


class TestNumSeconds(unittest.TestCase):
    '''Class to test numSeconds function'''   

    def test_simple_nn(self):
        self.assertEqual(numSeconds('20'), 20)

    def test_simple_sscc(self):
        self.assertEqual(numSeconds('12.34'), 12.34)

    def test_simple_mmsscc(self):
        self.assertEqual(numSeconds('1:02.34'), 62.34)

    def test_problematic_mmsscc(self):
        self.assertEqual(numSeconds('5:25.09'), 325.09)
        self.assertEqual(numSeconds('1:40.23'), 100.23)
        self.assertEqual(numSeconds('2:08.70'), 128.70)

    def test_simple_int(self):
        self.assertEqual(numSeconds(20), 20)

    def test_simple_float(self):
        self.assertEqual(numSeconds(62.344), 62.34)
        self.assertEqual(numSeconds(62.345), 62.34)
        self.assertEqual(numSeconds(62.346), 62.34)

    def test_problematic_float(self):
        self.assertEqual(numSeconds(325.09), 325.09)
        self.assertEqual(numSeconds(100.23), 100.23)
        self.assertEqual(numSeconds(128.70), 128.70)

    def test_dnf(self):
        self.assertEqual(numSeconds('DNF'), -1)

    def test_dns(self):
        self.assertEqual(numSeconds('DNS'), -2)

    def test_xxx(self):
        with self.assertRaises(ValueError):
            numSeconds('XXX')


# In[4]:


def formatResult(value, eventName = None, highlight = ''):
    '''Convert number of seconds to displayable time - e.g. 65.31 returns 1:05.31'''
    
    if value is not None:
        if value > 0:
            if eventName == '333fm':
                return '{}{:d}{}'.format(highlight, int(value), highlight)
            else:
                if value >= 60:
                    return '{}{:d}:{:05.2f}{}'.format(highlight, int(value // 60), value - int(value // 60) * 60, highlight)
                else:
                    return '{}{:.2f}{}'.format(highlight, value, highlight)
        else:
            if value == -1:
                return 'DNF'
            elif value == -2:
                return 'DNS'
            else:
                return '?'
    else:
        return ''


# In[5]:


class TestFormatResult(unittest.TestCase):
    '''Class to test formatResult function'''   

    def test_fm(self):
        self.assertEqual(formatResult(20, eventName = '333fm'), '20')

    def test_time(self):
        self.assertEqual(formatResult(62.34), '1:02.34')
        self.assertEqual(formatResult(1.23), '1.23')

    def test_highlight(self):
        self.assertEqual(formatResult(62.34, highlight = '*'), '*1:02.34*')
        self.assertEqual(formatResult(1.23, highlight = '*'), '*1.23*')

    def test_dnf(self):
        self.assertEqual(formatResult(-1), 'DNF')

    def test_dns(self):
        self.assertEqual(formatResult(-2), 'DNS')


# ## Run Unit Tests

# In[6]:


if __name__ == '__main__':
    unittest.main(argv=['first-arg-is-ignored'], exit=False)


# In[ ]:




