import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtWebEngine

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

        function getEdges(mouseX, mouseY) {
            let e = 0;
            if (mouseX < windowMargin) { e |= Qt.LeftEdge }
            if (mouseX >= width - windowMargin) { e |= Qt.RightEdge }
            if (mouseY < windowMargin) { e |= Qt.TopEdge }
            if (mouseY >= height - windowMargin) { e |= Qt.BottomEdge }
            return e;
        }

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

        onPressed: {
            let edges = getEdges(mouseX, mouseY);
            if (edges !== 0) {
                application.startSystemResize(edges);
            }else if(mouseY <= 25){
                application.startSystemMove();
            }
        }
    }

    //visible window rect
    Rectangle{
        id: window
        radius: 10
        color: "#121212"
        anchors.fill: parent

        ColumnLayout{
            anchors.fill: parent
            anchors.margins: application.windowMargin
            //titlebar
            Rectangle{
                id: titlebar

                height: 20
                topLeftRadius: 10
                topRightRadius: 10
                color: "transparent"

                //buttons
                Row{
                    anchors.fill: parent
                    padding: 5
                    spacing: 3

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
                }
            }

            WebEngineView{
                Layout.fillHeight: true
                Layout.fillWidth: true
                url: "https://fluxbrowserhome.netlify.app/"
            }
        }

    }
}