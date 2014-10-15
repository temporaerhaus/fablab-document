travis-ci buildserver and automatic upload
=======================

compile PDF-LATEX with travis-ci and deploy via sftp-upload

general setup:
* sign in on travis-ci.org, grant permissions from github
* sudo gem install travis -V
* create ssh user for uploads, see https://wiki.archlinux.org/index.php/SFTP_chroot for examples of securing this account (chroot and ForceCommand internal-sftp)
* make upload dir publicly available
* set short HTTP cache lifetime for upload dir (.htaccess with Expires directive), test with wget -d http://server/my/file, look for expires-header

set up for each repo
* add fablab-document/ as a submodule
* copy all files, including .travis.yml, from fau-fablab:document-dummy/ to the main repo
* change to repo main directory (NOT fablab-document/ subfolder)
* rm deployment/deployment_private_key.id_rsa.enc
* copy the private upload-key to ./deployment/deployment_private_key.id_rsa # do something like scp root@macgyver.fablab.fau.de:/home/buildserver-uploads/.ssh/id_rsa ./deployment/deployment_private_key.id_rsa
* travis login # needs github login
* travis encrypt-file ./deployment/deployment_private_key.id_rsa 
* mv deployment_private_key.id_rsa.enc deployment/
* open repo in travis, go to settings http://travis-ci.org/$USER/$REPO/settings/env_vars and set:
  * ENCRYPTION_VAR_NAME = 46f1a2582584
    * where 46f1a2582584 is the random (hashed?) part in the name of the encrypted_46f1a2582584_{key,iv} variables that ```travis encrypt-file``` created.
* commit and push $REPO/deployment/deployment_private_key.id_rsa.enc (NOT the unencrypted version)

