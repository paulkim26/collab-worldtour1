const { readFile, writeFile } = require('fs/promises');

/**
 * Format Room.room file.
 * 
 * @param   filePath    Path to Room.room file.
 */
const formatRoom = async (filePath, encoding = "utf8") => {
    // Read room file
    const fileContents = await readFile(filePath, encoding);
    const originalRoom = JSON.parse(fileContents);

    // Modify room vales
    const updatedRoom = roundValues(originalRoom);
    const updatedRoomString = JSON.stringify(updatedRoom, null, 4);

    // Write back to file
    await writeFile(filePath, updatedRoomString, encoding);
    console.log(`Formatted file '${filePath}'.`);
}

/**
 * Round floating point values in room file.
 * 
 * @param   room    Room.room as JSON object.
 * @param   digits  Number of digits after decimal point to round to.
 */
const roundValues = (room, digits = 3) => {
    room.cameraScreenshotPosition.x = Number(room.cameraScreenshotPosition.x.toFixed(digits))
    room.cameraScreenshotPosition.y = Number(room.cameraScreenshotPosition.y.toFixed(digits))
    room.cameraScreenshotPosition.z = Number(room.cameraScreenshotPosition.z.toFixed(digits))

    room.cameraScreenshotRotation.x = Number(room.cameraScreenshotRotation.x.toFixed(digits))
    room.cameraScreenshotRotation.y = Number(room.cameraScreenshotRotation.y.toFixed(digits))
    room.cameraScreenshotRotation.z = Number(room.cameraScreenshotRotation.z.toFixed(digits))

    room.cameraEditPosition.x = Number(room.cameraEditPosition.x.toFixed(digits))
    room.cameraEditPosition.y = Number(room.cameraEditPosition.y.toFixed(digits))
    room.cameraEditPosition.z = Number(room.cameraEditPosition.z.toFixed(digits))

    room.cameraEditRotation.x = Number(room.cameraEditRotation.x.toFixed(digits))
    room.cameraEditRotation.y = Number(room.cameraEditRotation.y.toFixed(digits))
    room.cameraEditRotation.z = Number(room.cameraEditRotation.z.toFixed(digits))

    for (const prop of room.props) {
        prop.transform.position.x = Number(prop.transform.position.x.toFixed(digits))
        prop.transform.position.y = Number(prop.transform.position.y.toFixed(digits))
        prop.transform.position.z = Number(prop.transform.position.z.toFixed(digits))

        prop.transform.rotation.x = Number(prop.transform.rotation.x.toFixed(digits))
        prop.transform.rotation.y = Number(prop.transform.rotation.y.toFixed(digits))
        prop.transform.rotation.z = Number(prop.transform.rotation.z.toFixed(digits))

        prop.transform.scale.x = Number(prop.transform.scale.x.toFixed(digits))
        prop.transform.scale.y = Number(prop.transform.scale.y.toFixed(digits))
        prop.transform.scale.z = Number(prop.transform.scale.z.toFixed(digits))

        if (prop.zoomable.length) {
            prop.zoomable[0].eyePosition.x = Number(prop.zoomable[0].eyePosition.x.toFixed(digits))
            prop.zoomable[0].eyePosition.y = Number(prop.zoomable[0].eyePosition.y.toFixed(digits))
            prop.zoomable[0].eyePosition.z = Number(prop.zoomable[0].eyePosition.z.toFixed(digits))

            prop.zoomable[0].eyeRotation.x = Number(prop.zoomable[0].eyeRotation.x.toFixed(digits))
            prop.zoomable[0].eyeRotation.y = Number(prop.zoomable[0].eyeRotation.y.toFixed(digits))
            prop.zoomable[0].eyeRotation.z = Number(prop.zoomable[0].eyeRotation.z.toFixed(digits))
        }

        if (prop._switch.length) {
            prop._switch[0].pivot.position.x = Number(prop._switch[0].pivot.position.x.toFixed(digits))
            prop._switch[0].pivot.position.y = Number(prop._switch[0].pivot.position.y.toFixed(digits))
            prop._switch[0].pivot.position.z = Number(prop._switch[0].pivot.position.z.toFixed(digits))

            prop._switch[0].pivot.rotation.x = Number(prop._switch[0].pivot.rotation.x.toFixed(digits))
            prop._switch[0].pivot.rotation.y = Number(prop._switch[0].pivot.rotation.y.toFixed(digits))
            prop._switch[0].pivot.rotation.z = Number(prop._switch[0].pivot.rotation.z.toFixed(digits))

            prop._switch[0].pivot.scale.x = Number(prop._switch[0].pivot.scale.x.toFixed(digits))
            prop._switch[0].pivot.scale.y = Number(prop._switch[0].pivot.scale.y.toFixed(digits))
            prop._switch[0].pivot.scale.z = Number(prop._switch[0].pivot.scale.z.toFixed(digits))
        }
    }

    return room;
}

formatRoom("./Room_collabwt1/Room.room");