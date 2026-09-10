import QtQuick
import Quickshell.Services.UPower
import qs.services

Item {
    id: root

    readonly property var device: UPower.displayDevice
    readonly property bool hasBattery: device.isLaptopBattery
    readonly property bool charging: device.state === UPowerDeviceState.Charging
        || device.state === UPowerDeviceState.PendingCharge
    readonly property real percentage: device.ready ? device.percentage : 0
    readonly property bool low: root.percentage <= 20 && !root.charging

    visible: Settings.showBattery && root.hasBattery
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    Row {
        id: row
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        Text {
            text: {
                if (!root.device.ready)
                    return "\uf244";
                if (root.charging)
                    return "\uf0e7";
                if (root.percentage >= 90)
                    return "\uf240";
                if (root.percentage >= 70)
                    return "\uf243";
                if (root.percentage >= 45)
                    return "\uf242";
                if (root.percentage >= 20)
                    return "\uf241";
                return "\uf244";
            }
            font.family: Theme.fontFamily
            font.pixelSize: 14
            color: root.charging ? Theme.gr0 : root.low ? Theme.er0 : Theme.fg1
        }

        Text {
            text: root.device.ready ? Math.round(root.percentage) + "%" : ""
            font.family: Theme.fontFamily
            font.pixelSize: 13
            color: root.low ? Theme.er0 : Theme.fg1
        }
    }
}