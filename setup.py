#!/usr/bin/env python3

"""
setup.py file for SWIG EuropeanOption
"""

from distutils.core import setup, Extension


EuropeanOption_module = Extension('_EuropeanOption',
                           sources=['EuropeanOption_wrap.cxx', 'EuropeanOption.cpp'],
                           )

setup (name = 'EuropeanOption',
       version = '0.1',
       author      = "SWIG Docs",
       description = """A simple swig example using some junky binary tree code EuropeanOption.""",
       ext_modules = [EuropeanOption_module],
       py_modules = ["EuropeanOption"],
       )
