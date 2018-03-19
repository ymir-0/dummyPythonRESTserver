#!/usr/bin/env python3
import os

import setuptools

module_path = os.path.join(os.path.dirname(__file__), 'DummyPythonRESTserver.py')

setuptools.setup(
    name="DummyPythonRESTserver",
    description="Dummy test for REST with Python3",
    py_modules=['DummyPythonRESTserver'],
    install_requires=["flask"],
    classifiers=[
        'Programming Language :: Python :: 3',
    ],
)
