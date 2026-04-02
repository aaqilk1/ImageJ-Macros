// ----------------------------------------
// Select registration image
// ----------------------------------------
regPath = File.openDialog("Choose registration image");
if (regPath=="") exit("No registration image selected.");

outDir = getDirectory("Choose output folder");
if (outDir=="") exit("No output folder selected.");


// ----------------------------------------
// Helper functions
// ----------------------------------------
function getFileName(path) {
    parts = split(path, "/");
    name = parts[parts.length-1];
    if (name=="") {
        parts = split(path, "\\\\");
        name = parts[parts.length-1];
    }
    return name;
}

function getParentDir(path) {
    slash = lastIndexOf(path, "/");
    if (slash==-1) slash = lastIndexOf(path, "\\");
    return substring(path, 0, slash+1);
}

function getGroupPrefix(name) {
    parts = split(name, "_");
    if (parts.length < 3)
        exit("Filename format not recognized: " + name);
    return parts[0] + "_" + parts[1] + "_";
}


// ----------------------------------------
// Parse paths
// ----------------------------------------
regName = getFileName(regPath);
parentDir = getParentDir(regPath);
groupPrefix = getGroupPrefix(regName);


// ----------------------------------------
// Open registration image and ask user for line
// ----------------------------------------
open(regPath);
regTitle = getTitle();

waitForUser("Draw a straight line along the edge you want to become horizontal, then click OK.");

roiType = selectionType();
if (roiType != 5)
    exit("Please draw a straight line ROI before continuing.");


// ----------------------------------------
// Compute angle directly from line endpoints
// ----------------------------------------
getSelectionCoordinates(xpoints, ypoints);

if (xpoints.length < 2)
    exit("Could not read the line ROI.");

// Endpoints
x1 = xpoints[0];
y1 = ypoints[0];
x2 = xpoints[xpoints.length-1];
y2 = ypoints[ypoints.length-1];

// Angle in image coordinates
lineAngle = atan2(y2 - y1, x2 - x1) * 180 / PI;

// This sign convention makes the drawn line become horizontal
rotation = lineAngle;


// ----------------------------------------
// Rotate registration image copy
// ----------------------------------------
selectWindow(regTitle);
run("Duplicate...", "title=rotated_registration");
selectWindow("rotated_registration");
run("Rotate...", "angle="+rotation+" interpolation=None enlarge");
saveAs("Tiff", outDir + "rotated_" + regName);
close();


// ----------------------------------------
// Rotate matching images in same folder
// ----------------------------------------
list = getFileList(parentDir);
setBatchMode(true);

for (i=0; i<list.length; i++) {
    name = list[i];

    if (endsWith(name, "/"))
        continue;

    if (!startsWith(name, groupPrefix))
        continue;

    if (name == regName)
        continue;

    open(parentDir + name);
    original = getTitle();

    run("Duplicate...", "title=rotated_copy");
    selectWindow("rotated_copy");
    run("Rotate...", "angle="+rotation+" interpolation=None enlarge");

    saveAs("Tiff", outDir + "rotated_" + name);
    close();

    selectWindow(original);
    close();
}

setBatchMode(false);


// ----------------------------------------
// Report
// ----------------------------------------
print("Registration image: " + regName);
print("Matching prefix: " + groupPrefix);
print("Line angle: " + lineAngle);
print("Applied rotation: " + rotation);
print("Done.");