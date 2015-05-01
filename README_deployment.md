How to deploy other documents
=============================

* in your project, include [fablab-document](https://github.com/fau-fablab/fablab-document) as git submodule.
* copy [`Makefile.example`](Makefile.example) to the main directory and adjust `TARGET`
* copy [`README.md.example`](README.md.example) to the main directory and adjust it
* copy [`gitignore.example`](gitignore.example) to the main direcory (`.gitignore`)
* check that make produces the required files in `output/`
* add the repository to the buildserver, see `macgyver.fablab.fau.de:/home/buildserver/README`
