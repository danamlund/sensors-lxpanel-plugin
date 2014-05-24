#!/bin/bash

PLUGIN_NAME="sensors.so"
EXISTING_LXPANEL_PLUGIN="deskno.so"

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
    PLUGINS_PATH=`pkg-config --variable=libdir lxpanel`/plugins
    if [ $? -eq 0 ]
    then
        echo $PLUGINS_PATH
        exit 0
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


if [ ! -e $PLUGIN_NAME ]
then
    echo Could not find $PLUGIN_NAME, call make.
    exit 1
fi

INSTALLPATH=$( find_install_path )

if [ $? -eq 0 ]
then
    cp -v ${PLUGIN_NAME} ${INSTALLPATH}
else
    echo "${INSTALLPATH}"
fi
