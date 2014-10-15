#!/bin/bash
set -e
deploydir="$(dirname $0)"
# needs to be run from main directory
if [[ "$TRAVIS_PULL_REQUEST" == "false" ]] && [[ "$TRAVIS_BRANCH" == "master" ]];  then
	# read variables $encrypted_....._key and _iv, the "..." part is set with ENCYRPTION_VAR_NAME
	key_var_name="encrypted_"$ENCYRPTION_VAR_NAME"_key"
	key=${!key_var_name}
	iv_var_name="encrypted_"$ENCYRPTION_VAR_NAME"_iv"
        iv=${!iv_var_name}
	openssl aes-256-cbc -K $key -iv $iv \
		-in deployment/deployment_private_key.id_rsa.enc -out deployment/deployment_private_key.id_rsa -d
	chmod 600 deployment/deployment_private_key.id_rsa
	sftp -i deployment/deployment_private_key.id_rsa -oUserKnownHostsFile=$deploydir/known_hosts -oPasswordAuthentication=no -b $deploydir/sftp_batch buildserver-uploads@macgyver.fablab.fau.de
else
	echo "skipping deployment: branch $TRAVIS_BRANCH pullrequest $TRAVIS_PULL_REQUEST"
fi
