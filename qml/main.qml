import QtQuick
import QtQuick.Controls

ApplicationWindow{
    id: application
    visible: true
    width: 900
    height: 800
    flags: Qt.FramelessWindowHint
    color: "transparent"

    property int windowMargin: 5

    function toggleMaximized() {
        if (application.visibility === Window.Maximized) {
            application.showNormal();
            window.radius = 10;
        } else {
            application.showMaximized();
            window.radius = 0;
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: {
            const p = Qt.point(mouseX, mouseY);
            const b = windowMargin; // Increase the corner size slightly
            if (p.x < b && p.y < b) return Qt.SizeFDiagCursor;
            if (p.x >= width - b && p.y >= height - b) return Qt.SizeFDiagCursor;
            if (p.x >= width - b && p.y < b) return Qt.SizeBDiagCursor;
            if (p.x < b && p.y >= height - b) return Qt.SizeBDiagCursor;
            if (p.x < b || p.x >= width - b) return Qt.SizeHorCursor;
            if (p.y < b || p.y >= height - b) return Qt.SizeVerCursor;
        }
        acceptedButtons: Qt.NoButton // don't handle actual events
    }

    DragHandler {
        id: resizeHandler
        grabPermissions: TapHandler.TakeOverForbidden
        target: null
        onActiveChanged: if (active) {
            const p = resizeHandler.centroid.position;
            const b = windowMargin + 10; // Increase the corner size slightly
            let e = 0;
            if (p.x < b) { e |= Qt.LeftEdge }
            if (p.x >= width - b) { e |= Qt.RightEdge }
            if (p.y < b) { e |= Qt.TopEdge }
            if (p.y >= height - b) { e |= Qt.BottomEdge }
            application.startSystemResize(e);
        }
    }

    //visible window rect
    Rectangle{
        id: window
        radius: 10
        color: "#121212"
        anchors.fill: parent

        //titlebar
        Rectangle{
            id: titlebar
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: application.windowMargin
            }

            height: 25
            topLeftRadius: 10
            topRightRadius: 10
            color: "transparent"

            DragHandler {
                grabPermissions: TapHandler.CanTakeOverFromAnything
                onActiveChanged: if (active) { application.startSystemMove(); }
            }

            //buttons
            Row{
                anchors.fill: parent
                padding: 5
                spacing: 3
                RoundButton{
                    id: minimizeButton
                    width: 13
                    height: 13

                    background: Rectangle{
                        radius: 20
                        width: parent.width
                        height: parent.height
                        color: "#7FFF74"
                    }

                    onClicked: application.showMinimized()
                }

                RoundButton{
                    id: maximizeButton
                    width: 13
                    height: 13

                    background: Rectangle{
                        radius: 20
                        width: parent.width
                        height: parent.height
                        color: "#FFEB36"
                    }

                    onClicked: toggleMaximized()
                }

                RoundButton{
                    id: closeButton
                    width: 13
                    height: 13

                    background: Rectangle{
                        radius: 20
                        width: parent.width
                        height: parent.height
                        color: "#FF4343"
                    }

                    onClicked: application.close()
                }
            }
        }


    }
}