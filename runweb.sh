#!/bin/sh

REPO=$HOME/proj/vsim

. $REPO/simenv >/dev/null || {
		echo "Failed to include simenv; Please fix runweb.sh"
		exit 1
	}

(cd $REPO && ghc --make happstack/WebServer.hs -o happstack/WebServer.exe; ) &&
echo running >&2 &&
$REPO/happstack/WebServer.exe `ospath $REPO`

