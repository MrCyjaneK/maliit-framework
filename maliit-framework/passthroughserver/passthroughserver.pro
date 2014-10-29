include(../config.pri)

TOP_DIR = ..

TEMPLATE = app
TARGET = $$MALIIT_SERVER
target.path = $$BINDIR
DEPENDPATH += .

include($$TOP_DIR/src/libmaliit-plugins.pri)
include($$TOP_DIR/common/libmaliit-common.pri)
include($$TOP_DIR/connection/libmaliit-connection.pri)

SOURCES += main.cpp

QT += core gui

# coverage flags are off per default, but can be turned on via qmake COV_OPTION=on
for(OPTION,$$list($$lower($$COV_OPTION))){
    isEqual(OPTION, on){
        QMAKE_CXXFLAGS += -ftest-coverage -fprofile-arcs -fno-elide-constructors
        LIBS += -lgcov
    }
}

packagesExist(qt5-boostable) {
    message("Building with qt5-boostable support")
    CONFIG += link_pkgconfig
    PKGCONFIG += qt5-boostable
} else {
    warning("qt5-boostable not available")
}


lipstick:DEFINES+=HAVE_LIPSTICK

QMAKE_CLEAN += *.gcno *.gcda

INSTALLS += target

QMAKE_EXTRA_TARGETS += check-xml
check-xml.target = check-xml
check-xml.depends += $$TARGET

QMAKE_EXTRA_TARGETS += check
check.target = check
check.depends += $$TARGET
