#!/usr/bin/env python3
import os

import setuptools

module_path = os.path.join(os.path.dirname(__file__), 'DummyPythonRESTserver.py')
version_line = [line for line in open(module_path)
                if line.startswith('__version__')][0]

__version__ = version_line.split('__version__ = ')[-1][1:][:-2]

setuptools.setup(
    name="DummyPythonRESTserver",
    version=__version__,
    description="Dummy test for REST with Python3",
    py_modules=['DummyPythonRESTserver'],
    install_requires=[],
    classifiers=[
        'Programming Language :: Python :: 3',
    ],
)
