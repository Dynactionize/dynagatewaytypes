#!/usr/bin/env bash

. .venv/bin/activate

twine upload dist/* --verbose

rm -rf dist/*