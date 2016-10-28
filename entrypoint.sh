#!/bin/bash

if [[ "${PYTHON_REQUIREMENTS}" != "" ]]; then
    pip install -r "${PYTHON_REQUIREMENTS}"
fi

exec $@
