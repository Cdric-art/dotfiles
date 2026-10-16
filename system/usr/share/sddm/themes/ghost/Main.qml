// SDDM — thème Ghost Pastel (https://omarchytheme.com/themes/ghost-pastel)
import QtQuick
import SddmComponents 2.0

Rectangle {
  id: root
  width: 1920
  height: 1080
  color: "#070506"

  readonly property color fg: "#ffffff"
  readonly property color accent: "#979fec"
  readonly property color muted: "#836f79"
  readonly property color red: "#b37580"
  readonly property string fontName: "Fira Code"

  property bool loginFailed: false
  property string currentUser: userModel.lastUser !== "" ? userModel.lastUser
                               : (userModel.count > 0 ? userModel.data(userModel.index(0, 0), Qt.UserRole + 1) : "")
  // Session Hyprland par défaut, sinon la dernière utilisée
  property int sessionIndex: {
    for (var i = 0; i < sessionModel.rowCount(); i++) {
      var name = (sessionModel.data(sessionModel.index(i, 0), Qt.DisplayRole) || "").toString()
      if (name.toLowerCase().indexOf("hyprland") !== -1)
        return i
    }
    return sessionModel.lastIndex
  }

  Connections {
    target: sddm
    function onLoginFailed() {
      root.loginFailed = true
      password.text = ""
      password.forceActiveFocus()
    }
    function onLoginSucceeded() { root.loginFailed = false }
  }

  // Fond : noir Ghost uni (couleur du Rectangle racine)

  Timer {
    interval: 1000; running: true; repeat: true; triggeredOnStart: true
    onTriggered: {
      var now = new Date()
      clock.text = Qt.formatTime(now, "HH:mm")
      date.text = now.toLocaleDateString(Qt.locale("fr_FR"), "dddd d MMMM")
    }
  }

  Column {
    anchors.centerIn: parent
    anchors.verticalCenterOffset: -60
    spacing: 18

    Text {
      id: clock
      anchors.horizontalCenter: parent.horizontalCenter
      color: root.fg
      font.family: root.fontName
      font.bold: true
      font.pixelSize: 120
    }
    Text {
      id: date
      anchors.horizontalCenter: parent.horizontalCenter
      color: root.accent
      font.family: root.fontName
      font.pixelSize: 24
    }

    Item { width: 1; height: 40 }

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: root.currentUser
      color: root.fg
      font.family: root.fontName
      font.pixelSize: 18
    }

    Rectangle {
      anchors.horizontalCenter: parent.horizontalCenter
      width: 320
      height: 46
      color: "#cc070506"
      border.width: 1
      border.color: root.loginFailed ? root.red : root.accent

      Text {
        anchors.centerIn: parent
        visible: password.text.length === 0
        text: root.loginFailed ? "Mot de passe incorrect" : "Mot de passe…"
        color: root.loginFailed ? root.red : root.muted
        font.family: root.fontName
        font.pixelSize: 15
      }

      TextInput {
        id: password
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: TextInput.AlignVCenter
        echoMode: TextInput.Password
        passwordCharacter: "●"
        color: root.fg
        font.family: root.fontName
        font.pixelSize: 16
        font.letterSpacing: 4
        selectByMouse: false
        cursorDelegate: Item {}
        focus: true
        onTextChanged: if (text.length > 0) root.loginFailed = false
        Keys.onPressed: function (event) {
          if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            sddm.login(root.currentUser, password.text, root.sessionIndex)
            event.accepted = true
          }
        }
      }
    }
  }

  // Session (bas gauche)
  Text {
    anchors.left: parent.left
    anchors.bottom: parent.bottom
    anchors.margins: 24
    text: (sessionModel.data(sessionModel.index(root.sessionIndex, 0), Qt.DisplayRole) || "")
    color: root.muted
    font.family: root.fontName
    font.pixelSize: 14
  }

  // Alimentation (bas droite)
  Row {
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.margins: 24
    spacing: 24

    Repeater {
      model: [
        { label: "Reboot", action: function () { sddm.reboot() } },
        { label: "Shut down", action: function () { sddm.powerOff() } }
      ]
      Text {
        text: modelData.label
        color: area.containsMouse ? root.accent : root.muted
        font.family: root.fontName
        font.pixelSize: 14
        MouseArea {
          id: area
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          onClicked: modelData.action()
        }
      }
    }
  }

  Component.onCompleted: password.forceActiveFocus()
}
