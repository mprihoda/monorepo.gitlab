#!/bin/bash

CF_RED="\e[1;31m"
CF_YELLOW="\e[1;33m"
CF_GREEN="\e[1;36m"
CF_NC="\e[0m"
CF_MAGENTA="\e[1;95m"
function pprint {
	CF_LOGGING_LEVEL=${1:-INFO}
	CF_LOGGING_LEVEL=$(echo "$CF_LOGGING_LEVEL" | tr '[:upper:]' '[:lower:]')
	CF_PREFIX=""
	case ${CF_LOGGING_LEVEL} in
		*info*) CF_COLOR=${CF_GREEN} ;CF_PREFIX="[INFO]";shift ;;
        *other*) CF_COLOR=${CF_MAGENTA} ;CF_PREFIX="";shift ;;
		*warn*) CF_COLOR=${CF_YELLOW} ; CF_PREFIX="[WARN]"; shift;;
		*error*) CF_COLOR=${CF_RED} ; CF_PREFIX="[ERROR]" ;shift ;;
		*) CF_COLOR=${CF_GREEN}; CF_PREFIX="[INFO]";;
	esac
	printf "${CF_COLOR}"; printf "\n ${CF_PREFIX} => $@ \n"; printf "${CF_NC}"
}

ROOT=$(git rev-parse --show-toplevel 2>/dev/null) || {
    ROOT=$PWD
}
ROOT_FOLDER_NAME=$(basename $ROOT)