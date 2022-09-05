import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.4

Window {
    id: window
    visible: true
    width: 720
    height: 480
    title: qsTr("Camera")

    Row {
        id: imageDisplay
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 15

        spacing: 15

        Rectangle {
            id: cameraController
            width: 320
            height: 180

            border.color: "#000000"
            border.width: 0

            Camera {
                id: camera

                //                viewfinder.resolution: "640x480"
                captureMode: Camera.CaptureStillImage

                onCameraStateChanged: {
                    console.log("camera state changed, " + camera.cameraState)
                    console.log("camera error, " + camera.errorString)
                }

                imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

                exposure {
                    exposureCompensation: -1.0
                    exposureMode: Camera.ExposurePortrait
                }

                flash.mode: Camera.FlashRedEyeReduction

                imageCapture {
                    onCaptureFailed: {
                        console.log("Capture failed, " + message)
                    }

                    onImageCaptured: {
                        photoPreview.source = preview // Show the preview in an Image
                    }

                    onImageMetadataAvailable: {
                        console.log("key: " + key + " value: " + value)
                    }

                    onImageSaved: {
                        console.log("Image saved to " + path)
                    }
                }
            }

            VideoOutput {
                source: camera
                anchors.fill: parent
                focus: visible // to receive focus and capture key events when visible

                MouseArea {
                    anchors.fill: parent
                    onClicked: camera.imageCapture.capture()
                }
            }
        }

        Image {
            id: photoPreview
            width: 320
            height: 180
        }
    }

    Row {
        id: captureButtons
        anchors.top: imageDisplay.bottom
        anchors.topMargin: 15

        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 15

        Button {
            text: qsTr("Capture")
            onClicked: {
                camera.imageCapture.capture()
            }
        }

        Button {
            text: qsTr("Cancel Capture")
            onClicked: {
                camera.imageCapture.cancelCapture()
                photoPreview.source = "" // Clear the preview
            }
        }

        Button {
            text: qsTr("Capture To Location")
            onClicked: {
                camera.imageCapture.captureToLocation("C:/Windows/Temp")
            }
        }
    }

    Row {
        id: cameraButtons
        anchors.top: captureButtons.bottom
        anchors.topMargin: 15

        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 15

        Button {
            text: qsTr("Start Camera")
            onClicked: {
                camera.start()
            }
        }

        Button {
            text: qsTr("Stop Camera")
            onClicked: {
                camera.stop()
            }
        }

        Button {
            text: qsTr("Supported Frame Rate Ranges")
            onClicked: {
                var ranges = camera.supportedViewfinderFrameRateRanges()
                console.log("Supported Frame Rate Ranges:")
                for (var i = 0; i < ranges.length; i++) {
                    console.log(ranges[i].minimumFrameRate + " - " + ranges[i].maximumFrameRate)
                }
            }
        }

        Button {
            text: qsTr("Supported Resolutions")
            onClicked: {
                var resolutions = camera.supportedViewfinderResolutions()
                console.log("Supported Resolutions:")
                for (var i = 0; i < resolutions.length; i++) {
                    console.log(resolutions[i].width + "x" + resolutions[i].height)
                }
            }
        }
    }

    Component.onCompleted: {
        console.log("capturedImagePath=" + camera.imageCapture.capturedImagePath)
        console.log("errorString=" + camera.imageCapture.errorString)
        console.log("ready=" + camera.imageCapture.ready)
        console.log("resolution=" + camera.imageCapture.resolution)
        console.log("supportedResolutions=" + camera.imageCapture.supportedResolutions)
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/

