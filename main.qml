import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: applicationWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("my_qml_1")
//    Keys.enabled: true;
//    Keys.onPressed: {
//        switch(event.key)
//        {
//        case Qt.Key_Up:
//            rect1.color = "#F0F0F0"
//        }
//    }

//    ScrollView {
//        anchors.fill: parent

//        ListView {
//            anchors.centerIn: parent
//            id: listView
//            width: parent.width
//            model: 20
//            delegate: ItemDelegate {
//                text: Qt.md5("Item " + (index + 1))
//                width: listView.width
//            }
//        }
//    }
//        Rectangle{
//            width: 300
//            height: 200

//            visible: true
//            Text {
//                anchors.centerIn: parent
//                id: text1
//                text: qsTr("text")
//            }
//        }
    /*
    Rectangle{
        id: rect1
        anchors.fill: parent
        width: 300
        height: 300
        Keys.enabled:true
        Keys.onPressed:{
                switch(event.key)
                {
                case Qt.Key_Up:
                    quit.y = quit.y-50
                    break;
                }
            }

        gradient: Gradient{
            GradientStop{
                position: 0.0
                color: "#202020"
            }
            GradientStop{
                position: 0.33
                color: "blue"
            }
            GradientStop{
                position: 1.0;
                color: "#FFFFFF"
            }
        }
    }


    MouseArea{
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        onClicked: {
            Qt.quit();
        }
    }
    Text {
        y: 234
        text: qsTr("Hello world!")
        anchors.bottom: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        transformOrigin: Item.Center
        anchors.bottomMargin: -6
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Button {
        id:quit
        x:300
        y:300;
        opacity: 0.3;

        width: 100;
        height: 40;
        text: qsTr("quit")
        onClicked: {
            rect1.visible = !rect1.visible
        }
    }
    */
    BusyIndicator{
        id:busy;
        running: false;
        anchors.centerIn: parent;
        z:2;
    }
    Text {
        id: stateLabel;
        visible: false;
        anchors.centerIn: parent;
        z:3;
    }
    Image {
        id: imageViewer;
        asynchronous: true;
        anchors.fill: parent;
        fillMode: Image.PreserveAspectFit;
        onStatusChanged: {
            if(imageViewer.status == Image.Loading)
            {
                busy.running = true;
                stateLabel.visible = false;
            }
            else if(imageViewer.status == Image.Ready)
            {
                busy.running = false;
            }
            else if(imageViewer.status == Image.Error)
            {
                busy.running = false;
                stateLabel.visible = true;
                stateLabel.text = "ERROR";
            }
        }
    }
    Button {
        id:openFile;
        text: "Open";
        anchors.left: parent.left;
        anchors.leftMargin: 8;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 8;
        background: Rectangle{
            implicitWidth: 70
            implicitHeight:25
            border.color: openFile.down ? "#17a81a" : "#21be2b";
            border.width: openFile.pressed ? 2: 1;
            radius: 2
            color: openFile.down ? "blue" : "gray"
        }

//        style:ButtonStyle{
//            background: Rectangle{
//                implicitWidth: 70;
//                implicitHeight: 25;
//                color: control.hovered ? "c0c0c0":"#a0a0a0";
//                border.width: control.pressed ? 2:1;
//                border.color: (control.hovered || control.pressed) ? "green" : "#888888";
//            }

//        }
        onClicked: fileDialog.open();
        z:4
    }
    Text {
        id: imagePath;
        anchors.left: openFile.right;
        anchors.leftMargin: 8;
        anchors.verticalCenter: openFile.verticalCenter;
        font.pixelSize: 18;
    }
    FileDialog{
        id:fileDialog;
        title: "Please choose a file";
        nameFilters: ["Image Files (*.jpg *.png *.gif)"];
        onAccepted: {
            imageViewer.source = fileDialog.fileUrl;
            var imageFile = new String(fileDialog.fileUrl);
            imagePath.text = imageFile.slice(8);
        }
    }
}
