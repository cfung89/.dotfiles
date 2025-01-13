#! /bin/bash

if [ -f requirements.txt ]; then
    source .venv/bin/activate
fi
if [ -f requirements.txt ]; then
    pip install -r requirements.txt
fi
