import QtQuick 2.0
import Sailfish.Silica 1.0

import StationListModel 1.0

BackgroundItem {
    property var station : undefined

    id: index
    height: mainColumn.height

    Column {
        id: mainColumn
        width: parent.width
        spacing: Theme.paddingMedium

        Column {
            width: parent.width
            Label {
                id: cityLabel
                text: station ? station.cityName : " "
                horizontalAlignment: Text.AlignRight
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                anchors.right: parent.right
                truncationMode: TruncationMode.Fade
                anchors.rightMargin: Theme.horizontalPageMargin
            }

            Label {
                id: streetLabel
                text: station ? station.streetName : " "
                horizontalAlignment: Text.AlignRight
                color: Theme.highlightColor
                anchors.right: parent.right
                truncationMode: TruncationMode.Fade
                anchors.rightMargin: Theme.horizontalPageMargin
                font.pixelSize: Theme.fontSizeMedium
            }
        }

        Item {
            id: row
            width: parent.width
            height: Math.max(image.height, dataColumn.height)
            anchors.margins: Theme.horizontalPageMargin
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: image
                height: 256
                source: "qrc:///Graphics/weatherIcons/256/" + station.stationIndex.id + ".png"
                anchors.centerIn: parent
            }

            Column {
                id: dataColumn
                anchors.right: parent.right
                anchors.bottom: image.bottom
                anchors.rightMargin: Theme.horizontalPageMargin


                Label {
                    id: distanceLabel
                    text: station.distance + " km"
                    horizontalAlignment: Text.AlignRight
                    color: Theme.secondaryColor
                    anchors.right: parent.right
                    visible: station.distance
                    font.pixelSize: Theme.fontSizeMedium
                }

                Label {
                    id: date
                    text: station.stationIndex.date
                    horizontalAlignment: Text.AlignRight
                    color: Theme.secondaryColor
                    anchors.right: parent.right
                    font.pixelSize: Theme.fontSizeMedium
                }

                Label {
                    id: indexVersion
                    text: station.stationIndex.calculationModeName
                    horizontalAlignment: Text.AlignRight
                    color: Theme.secondaryColor
                    anchors.right: parent.right
                    font.pixelSize: Theme.fontSizeMedium
                }
                Label {
                    id: providerLabel
                    text: station.providerName
                    horizontalAlignment: Text.AlignRight
                    color: Theme.secondaryColor
                    anchors.right: parent.right
                    font.pixelSize: Theme.fontSizeMedium
                }
            }
        }

        Label {
            id: label

            text: station ? station.stationIndex.name : " "
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Theme.fontSizeLarge
        }
    }
}
