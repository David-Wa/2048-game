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
    QML_FILES
        main.qml
        MenuButton.qml
        Tile.qml
        Cell.qml
    RESOURCES
        couleurs.jpg
    SOURCES


        damierdyn.h
        damierdyn.cpp
        menubutton.h
        colorpicker.cpp
        colorpicker.h
        menubutton.cpp
        direction.h
        board.cpp
        tile.cpp
        boardmodel.cpp
        game.cpp
        gamecontroller.cpp
        board.h
        boardmodel.h
        game.h
        gamecontroller.h
        tile.h
)

# Ajouter les ressources séparément
qt_add_resources(appProjet "ressources.qrc")

set_target_properties(appProjet PROPERTIES
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
