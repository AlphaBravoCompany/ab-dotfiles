#!/usr/bin/env bash

## Prevent the script from being executed from the home folder.  Will cause symlink loops!
if [ "${PWD}" == "${HOME}" ]; then
    echo -e "\n=====\nCRITICAL:\nThis script should NOT be ran from your home folder, ${HOME}.  Doing so causes signficant failures.\nExiting to prevent execution.\n=====\n"
    exit 0
fi

## Prevent the file from being executed from the scripts folder.  It should really only be executed via the install.sh script.
echo ${PWD} | grep scripts &> /dev/null
if [ $? -eq 0 ]; then
    echo "Please run this script from the dotfiles directory: scripts/sync.sh"
    exit 0
fi

## Synchronize function
function sync() {
    local sourceFile="$1"
    local validateFile=`test -f ${HOME}/${sourceFile} && echo True || echo False`
    local mvDate=`date +'%s'`
    ## Verify if the file exists
    if [ "$validateFile" == "True" ]; then
        ## Verify if the file is a symlink, which we have to just remove the symlink.
        if [[ -L "${HOME}/${sourceFile}" ]]; then 
            echo "The file, ${HOME}/${sourceFile}, is a symbolic link. Removing."
            rm ${HOME}/${sourceFile}
            echo "Creating symlink: ${HOME}/${sourceFile}"
            ln -sf ${PWD}/${sourceFile} ${HOME}/${sourceFile}
        ## Otherwise, back up the file and create a symlink to the dotfile.
        else
            echo "Backing up existing file to ${HOME}/${sourceFile}-${mvDate}"
            mv ${HOME}/${sourceFile} ${HOME}/${sourceFile}-${mvDate}
            echo "Creating symlink: ${HOME}/${sourceFile}"
            ln -sf ${PWD}/${sourceFile} ${HOME}/${sourceFile}
        fi
    ## Otherwise, just symlink the file if nothing exists.
    else
        echo "Creating symlink: ${HOME}/${sourceFile}"
        ln -sf ${PWD}/${sourceFile} ${HOME}/${sourceFile}
    fi
}

## Function to run sync function.
function doSync() {
    ## Get a list of all dotfiles in the dotfile repo root directory, and assign them to the array DOTFILES.
    DOTFILES=($(ls -ld ${PWD}/.??* | grep -v ".git$" | awk -F "." {' print $2 '}))
    ## Iterate over the returned results in the array, set as ${i}, and passing the result to the sync function.
    for i in "${DOTFILES[@]}"
    do
        sync ".${i}"
    done
    return 0
}

## Check to see if we're forcing, otherwise put up a note asking what to do.
if [ "$1" == "--force" -o "$1" == "-f" ]; then
    echo -e "NOTICE: Forcing synchronization.\n"
	doSync
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	if [[ $REPLY =~ ^[Yy]$ ]]; then
	    doSync
    else
        printf "Aborted.\n\n"
        exit 0
	fi
fi

unset doSync