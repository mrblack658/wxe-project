import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: rootWindow
    visible: true
    width: 700
    height: 480
    title: "WXE Control Center"
    color: "#1e1e2e"

    property bool wxeActive: false
    property bool isRu: true
    property string timeStr: "00:00:00"
    property string dateStr: "01.01.2026"
    property int stopwatchTime: 0
    property bool stopwatchRunning: false

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            var date = new Date()
            rootWindow.timeStr = date.toLocaleTimeString(Qt.locale(rootWindow.isRu ? "ru_RU" : "en_US"), "hh:mm:ss")
            rootWindow.dateStr = date.toLocaleDateString(Qt.locale(rootWindow.isRu ? "ru_RU" : "en_US"), "dd.MM.yyyy")
            if (rootWindow.stopwatchRunning) {
                rootWindow.stopwatchTime++
            }
        }
    }

    function formatStopwatch(seconds) {
        var m = Math.floor(seconds / 60)
        var s = seconds % 60
        return (m < 10 ? "0" : "") + m + ":" + (s < 10 ? "0" : "") + s
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.width: 2
        border.color: rootWindow.wxeActive ? "#a6e3a1" : "#cba6f7"
        radius: 12
        anchors.margins: 1
        clip: true

        Rectangle {
            id: topBar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 40
            color: "#11111b"
            radius: 12

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: 6
                color: "#11111b"
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 15
                anchors.rightMargin: 15

                Text {
                    text: " WXE OS"
                    font.family: "JetBrains Mono"
                    font.bold: true
                    font.pointSize: 11
                    color: "#cba6f7"
                }

                Item { Layout.fillWidth: true }

                Text {
                    text: " " + rootWindow.timeStr
                    font.family: "JetBrains Mono"
                    font.pointSize: 11
                    color: "#f9e2af"
                }

                Item { width: 15 }

                Button {
                    id: langButton
                    width: 40
                    height: 25
                    text: rootWindow.isRu ? "EN" : "RU"
                    background: Rectangle {
                        color: langButton.hovered ? "#313244" : "#1e1e2e"
                        border.color: "#45475a"
                        radius: 4
                    }
                    contentItem: Text {
                        text: langButton.text
                        color: "#cdd6f4"
                        font.family: "JetBrains Mono"
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: rootWindow.isRu = !rootWindow.isRu
                }

                Item { width: 5 }

                Button {
                    id: panelToggle
                    width: 30
                    height: 25
                    text: sidePanel.opened ? "➔" : "☰"
                    background: Rectangle {
                        color: panelToggle.hovered ? "#313244" : "#1e1e2e"
                        border.color: "#45475a"
                        radius: 4
                    }
                    contentItem: Text {
                        text: panelToggle.text
                        color: "#cba6f7"
                        font.family: "JetBrains Mono"
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: sidePanel.opened = !sidePanel.opened
                }
            }
        }

        Item {
            anchors.top: topBar.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 25

                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 8

                    Text {
                        text: "WXE"
                        font.family: "JetBrains Mono"
                        font.pointSize: 36
                        font.bold: true
                        color: rootWindow.wxeActive ? "#a6e3a1" : "#cba6f7"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Text {
                        text: rootWindow.isRu ? "привет, wxe готов к работе" : "hello, wxe is ready to work"
                        font.family: "JetBrains Mono"
                        font.pointSize: 13
                        color: "#cdd6f4"
                        Layout.alignment: Qt.AlignHCenter
                    }
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 12

                    Rectangle {
                        width: 12
                        height: 12
                        radius: 6
                        color: rootWindow.wxeActive ? "#a6e3a1" : "#f38ba8"

                        SequentialAnimation on opacity {
                            running: true
                            loops: Animation.Infinite
                            PropertyAnimation { to: 0.4; duration: 800 }
                            PropertyAnimation { to: 1.0; duration: 800 }
                        }
                    }

                    Text {
                        text: rootWindow.isRu ? (rootWindow.wxeActive ? "Статус: процесс запущен" : "Статус: не активен")
                                               : (rootWindow.wxeActive ? "Status: running" : "Status: inactive")
                        font.family: "JetBrains Mono"
                        font.pointSize: 11
                        font.bold: true
                        color: rootWindow.wxeActive ? "#a6e3a1" : "#f38ba8"
                    }
                }

                Button {
                    id: actionButton
                    Layout.alignment: Qt.AlignHCenter
                    implicitWidth: 230
                    implicitHeight: 50
                    enabled: !rootWindow.wxeActive
                    text: rootWindow.isRu ? "🚀 ЗАПУСТИТЬ WXE" : "🚀 LAUNCH WXE"

                    background: Rectangle {
                        color: !actionButton.enabled ? "#181825" : (actionButton.hovered ? "#313244" : "#11111b")
                        border.color: !actionButton.enabled ? "#313244" : (actionButton.hovered ? "#a6e3a1" : "#45475a")
                        border.width: actionButton.hovered ? 2 : 1
                        radius: 8
                    }
                    contentItem: Text {
                        text: actionButton.text
                        color: actionButton.enabled ? "#cdd6f4" : "#585b70"
                        font.family: "JetBrains Mono"
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: rootWindow.wxeActive = true
                }
            }
        }

        Rectangle {
            id: sidePanel
            property bool opened: false

            anchors.top: topBar.bottom
            anchors.bottom: parent.bottom
            anchors.margins: 1
            width: 220
            color: "#11111b"
            border.color: "#313244"
            border.width: 1
            radius: 8

            x: opened ? rootWindow.width - width - 2 : rootWindow.width + 10

            Behavior on x {
                NumberAnimation { duration: 250; easing.type: Easing.OutQuad }
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 20

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 5

                    Text {
                        text: rootWindow.isRu ? "📅 Календарь" : "📅 Calendar"
                        font.family: "JetBrains Mono"
                        font.bold: true
                        font.pointSize: 11
                        color: "#89b4fa"
                    }
                    Text {
                        text: rootWindow.dateStr
                        font.family: "JetBrains Mono"
                        font.pointSize: 13
                        color: "#cdd6f4"
                    }
                }

                Rectangle { height: 1; Layout.fillWidth: true; color: "#313244" }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 5

                    Text {
                        text: rootWindow.isRu ? "🌤️ Погода" : "🌤️ Weather"
                        font.family: "JetBrains Mono"
                        font.bold: true
                        font.pointSize: 11
                        color: "#a6e3a1"
                    }
                    Text {
                        text: "⚡ +18°C / Stormy"
                        font.family: "JetBrains Mono"
                        font.pointSize: 12
                        color: "#cdd6f4"
                    }
                }

                Rectangle { height: 1; Layout.fillWidth: true; color: "#313244" }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    Text {
                        text: rootWindow.isRu ? "⏱️ Секундомер" : "⏱️ Stopwatch"
                        font.family: "JetBrains Mono"
                        font.bold: true
                        font.pointSize: 11
                        color: "#f9e2af"
                    }

                    Text {
                        text: rootWindow.formatStopwatch(rootWindow.stopwatchTime)
                        font.family: "JetBrains Mono"
                        font.pointSize: 18
                        font.bold: true
                        color: "#cdd6f4"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 10

                        Button {
                            id: swStartButton
                            implicitWidth: 70
                            implicitHeight: 28
                            text: rootWindow.stopwatchRunning ? (rootWindow.isRu ? "Пауза" : "Pause") : (rootWindow.isRu ? "Старт" : "Start")
                            background: Rectangle {
                                color: swStartButton.hovered ? "#313244" : "#1e1e2e"
                                border.color: rootWindow.stopwatchRunning ? "#f38ba8" : "#a6e3a1"
                                radius: 4
                            }
                            contentItem: Text {
                                text: swStartButton.text
                                color: "#cdd6f4"
                                font.family: "JetBrains Mono"
                                font.pointSize: 9
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: rootWindow.stopwatchRunning = !rootWindow.stopwatchRunning
                        }

                        Button {
                            id: swResetButton
                            implicitWidth: 70
                            implicitHeight: 28
                            text: rootWindow.isRu ? "Сброс" : "Reset"
                            background: Rectangle {
                                color: swResetButton.hovered ? "#313244" : "#1e1e2e"
                                border.color: "#45475a"
                                radius: 4
                            }
                            contentItem: Text {
                                text: swResetButton.text
                                color: "#cdd6f4"
                                font.family: "JetBrains Mono"
                                font.pointSize: 9
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: {
                                rootWindow.stopwatchRunning = false
                                rootWindow.stopwatchTime = 0
                            }
                        }
                    }
                }

                Item { Layout.fillHeight: true }
            }
        }
    }
}
