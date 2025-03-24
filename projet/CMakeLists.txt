cmake_minimum_required(VERSION 3.16)

project(Projet VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appProjet
    main.cpp
)

qt_add_qml_module(appProjet
    URI Projet
    VERSION 1.0
        QML_FILES InterfaceJeu.qml
        RESOURCES ressources.qrc
        QML_FILES MenuButton.qml
        QML_FILES InterfaceMenu.qml
        SOURCES menubutton.h menubutton.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appProjet PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appProjet
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appProjet
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appProjet
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
