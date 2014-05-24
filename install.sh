#!/bin/bash

PLUGIN_NAME="sensors.so"
EXISTING_LXPANEL_PLUGIN="deskno.so"

if [ ! -e $PLUGIN_NAME ]
then
    echo Could not find $PLUGIN_NAME, call make.
    exit 1
fi

# The user can set LXPANEL_PLUGINS_DIR to simply install to that directory
# e.g. export LXPANEL_PLUGINS_DIR=/usr/lib/lxpanel/plugins
if [ "$LXPANEL_PLUGINS_DIR" ]
then
    cp -v ${PLUGIN_NAME} "$LXPANEL_PLUGINS_DIR"
    exit 0
fi

check_results() {
    RESULTS="$@"

    RESULTSLEN=0
    for result in $RESULTS
    do
        RESULTSLEN=$(($RESULTSLEN + 1))
    done
    
    if [ $RESULTSLEN -eq 1 ]
    then
        echo $(dirname $RESULTS)
        exit 0
    elif [ $RESULTSLEN -gt 1 ]
    then
        echo Multiple possible plugin locations found.
        echo Manually copy $PLUGIN_NAME to the correct one:
        for result in $RESULTS
        do
            echo $(dirname $result)
        done
        exit 1
    else
        exit 2
    fi
}

find_install_path() {
    LXPANEL_LIBDIR=`pkg-config --variable=libdir lxpanel`
    # not sure if this returns /lib/lxpanel/plugins, /lib or /lib/lxpanel
    # so we search for builtin plugin in what we get out
    if [ $? -eq 0 ]
    then
        OUT=$(check_results $(find "$LXPANEL_LIBDIR" \
                                   -name $EXISTING_LXPANEL_PLUGIN \
                                   2> /dev/null))
        ERRCODE=$?
        if [ ! $ERRCODE -eq 2 ]
        then
            echo "${OUT}"
            exit $ERRCODE
        fi
    fi
    
    OUT=$(check_results $(locate $EXISTING_LXPANEL_PLUGIN))
    ERRCODE=$?
    if [ ! $ERRCODE -eq 2 ]
    then
        echo "${OUT}"
        exit $ERRCODE
    fi

    for libdir in /usr/lib /usr/lib64 /usr/local/lib /usr/local/lib64 /usr
    do
        OUT=$(check_results $(find $libdir -name $EXISTING_LXPANEL_PLUGIN \
                                   2> /dev/null))
        ERRCODE=$?
        if [ ! $ERRCODE -eq 2 ]
        then
            echo "${OUT}"
            exit $ERRCODE
        fi
    done
    echo Could not find lxpanel/plugins
    
    exit 2
}


INSTALLPATH_OR_ERROR=$( find_install_path )

if [ $? -eq 0 ]
then
    mkdir -p "${DESTDIR}${INSTALLPATH_OR_ERROR}"
    cp -v ${PLUGIN_NAME} "${DESTDIR}${INSTALLPATH_OR_ERROR}"
else
    echo "${INSTALLPATH_OR_ERROR}"
fi
