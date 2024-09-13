import QtQuick
import QtQuick.Controls

ApplicationWindow{
    visible: true
    width: 900
    height: 800
    flags: Qt.FramelessWindowHint
    color: "transparent"

    Rectangle{
        radius: 10
        clip: true
        color: "#121212"
        anchors.fill: parent
    }
}