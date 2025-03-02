#!/bin/bash

DATAFILE_INTRO=/var/tmp/pullweatherd.txt
LOCATION="" # Keep empty for auto location

# init() function checks datafile and creates if not exists
init() {
    # Check if DATAFILE_INTRO exists, create if not
    if [ ! -f $DATAFILE_INTRO ]; then
        if ! touch $DATAFILE_INTRO; then
            printf "pullweatherd: Error creating %s\n" "$DATAFILE_INTRO"
            exit 1
        fi
    fi
}

init

# Write the date to the datafile
if ! date > $DATAFILE_INTRO; then
    printf "pullweatherd: Error writing to %s" "$DATAFILE_INTRO"
    exit 1
fi

REQUEST_INTRO="wttr.in/$LOCATION?0q"

if ! curl --silent "$REQUEST_INTRO" >> "$DATAFILE_INTRO"; then
    printf "pullweatherd: Error writing to %s" "$DATAFILE_INTRO"
    exit 1
fi
