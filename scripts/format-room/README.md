## format-room

This is a GitHub action workflow script that automatically rounds/formats the floating point values in the `Room.room` file. This is to avoid polluting the commit history with fluctuating floating point values generated in Escape Simulator.

### Usage

#### GitHub Actions

Copy the `format-room.yml` file into the directory `.github/workflows/format-room.yml`. The GitHub workflow `.github/workflows/format-room.yml` will then automatically run via GitHub actions after each push.

#### Manual Run

The formatting script can be manually run:

1. Install [node.js](https://nodejs.org/en).
2. Run command `node format-room.js`.

### Notes

- All pull requests need to squash and merge commits for this to be effective.
- This may impact the stability of the room as certain puzzles/objects may rely on a higher level of precision (>5 digits after the decimal point). Thorough testing is required.




