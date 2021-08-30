# overwrite https://cgit.openembedded.org/openembedded-core/tree/meta/recipes-support/boost/boost.inc?h=master
# installing only the used packages instead of all packages saves us 13 MB
BOOST_LIBS = "\
    filesystem \
    log \
    program_options \
    system \
    thread \
    atomic regex chrono \
"

# someone installs "atomic regex chrono", who?
# anyway just add them 
