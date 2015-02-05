#!/bin/bash
cd `dirname $0`
module="$(osascript lib/ModuleSelector.applescript)"
./conncheck.sh $module &
