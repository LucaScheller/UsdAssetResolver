# Source repo
if [ ! $REPO_SOURCED ]
then
    # Define repo root
    export REPO_SOURCED=1
    export REPO_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && (pwd -W 2> /dev/null || pwd))
    # Define Resolver > Has to be one of 'fileResolver'/'pythonResolver'/'cachedResolver'/'httpResolver'
    export RESOLVER_NAME=fileResolver
    export RESOLVER_NAME_UPPERCASE=$(echo ${RESOLVER_NAME} | tr '[:lower:]' '[:upper:]')
    # Source Houdini (This defines what Houdini version to compile against)
    pushd $HOUDINI_INSTALLATION_DIR > /dev/null
    source houdini_setup
    popd > /dev/null
    export HOUDINI_LMINFO_VERBOSE=1
    # Source env
    export PYTHONPATH=${REPO_ROOT}/dist/${RESOLVER_NAME}/lib/python:${PYTHONPATH}
    export PXR_PLUGINPATH_NAME=${REPO_ROOT}/dist/${RESOLVER_NAME}/resources:${PXR_PLUGINPATH_NAME}
    export LD_LIBRARY_PATH=${REPO_ROOT}/dist/${RESOLVER_NAME}/lib:${LD_LIBRARY_PATH}
    alias  usdpython="$HFS/python/bin/python $@"
    # Configure resolver
    export AR_SEARCH_PATHS=${REPO_ROOT}/files
    export AR_SEARCH_REGEX_EXPRESSION="(bo)"
    export AR_SEARCH_REGEX_FORMAT="Bo"
    # Debug
    # export TF_DEBUG=${RESOLVER_NAME_UPPERCASE}_RESOLVER
    export TF_DEBUG=AR_RESOLVER_INIT
    # Log
    echo "The resolver environment for resolver '${RESOLVER_NAME}' has been initialized." 
fi


