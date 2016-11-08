#!/bin/bash

export SCREEN="${WIDTH}x${HEIGHT}x${COLOR}"
export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES="${WIDTH}x${HEIGHT}"
export WINDOW_SIZE="${WIDTH},${HEIGHT}"

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
