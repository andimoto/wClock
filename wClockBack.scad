
module wClockBack(chamberElementsX=11, chamberElementsY=10,
        ccubeSize=10, ledCaseHight=10, squareShape=true,
        borderThickness=2, bottomThickness=2,
        useAbsLength=false, absoluteLengthX=180, absoluteLengthY=180,
        additionalBorder=false, additionalBorderLength=10 ){

hCableHole=bottomThickness+grafixComp;

/* should be higher due to see
the cubes over the case surface */
 cubeHight = caseHight - bottomThickness + grafixComp;

/* calculate longest side of case
to get a square case with similar lengths */
caseSizeMax = (chamberElementsX < chamberElementsY) ?
    ((chamberElementsY *
        (ccubeSize + borderThickness)) + borderThickness) :
    ((chamberElementsX *
        (ccubeSize + borderThickness)) + borderThickness);
echo("Max Case Size from Cubes:",caseSizeMax,"mm");

minCaseSizeX = ((chamberElementsX *
    (ccubeSize + borderThickness)) + borderThickness);
minCaseSizeY = ((chamberElementsY *
    (ccubeSize + borderThickness)) + borderThickness);

caseSizeX = (squareShape) ? caseSizeMax : minCaseSizeX;
caseSizeY = (squareShape) ? caseSizeMax : minCaseSizeY;
echo("x & y Case Size:",caseSizeX, "x",caseSizeY,"mm");

/* calculate Case Size with passepartout */
addBorderX = (additionalBorder) ? additionalBorderLength*2 : 0;
addBorderY = (additionalBorder) ? additionalBorderLength*2 : 0;
echo("Add in X Direction: ",addX);
echo("Add in Y Direction: ",addY);

/* case should be absolute size if
it does not exeed and is enabled */
addTotalX = (caseSizeX > absoluteLengthX) ? 0 :
    (absoluteLengthX - caseSizeX);
addTotalY = (caseSizeY > absoluteLengthY) ? 0 :
    (absoluteLengthY - caseSizeY);

addX = (useAbsLength) ? (addBorderX + addTotalX) : addBorderX;
addY = (useAbsLength) ? (addBorderY + addTotalY) : addBorderY;

/* when elements in X & Y direction are not equal,
all cutout cubes have to be shifted into the middle
from each direction */
borderShiftX= (caseSizeX -
    ((ccubeSize+borderThickness)
    * chamberElementsX) - borderThickness)/2
    + addX/2;

borderShiftY= (caseSizeY -
    ((ccubeSize+borderThickness)
    * chamberElementsY) - borderThickness)/2
    + addY/2;



    translate([-(borderThickness+0.25),
        -(borderThickness+0.25),0]){
    difference(){
    union(){
        color("green") cube([caseSizeX+addX+borderThickness*2+0.5,
            caseSizeY+addY+borderThickness*2+0.5,bottomThickness]);

        translate([borderThickness+0.25,
            borderThickness+0.25,0]){
            /* cube([caseSizeX+addX,
                caseSizeY+addY,bottomThickness*2]); */
            cube([caseSizeX+addX,
                caseSizeY+addY,cubeHight-ledCaseHight+0.8]);
            }
        } /* union */
        translate([borderThickness+10,
            borderThickness,bottomThickness])
            cube([caseSizeX-20,
            caseSizeY+1,cubeHight-ledCaseHight+0.8]);
        translate([borderThickness,
            borderThickness+10,bottomThickness])
            cube([caseSizeX+1,
            caseSizeY-20,cubeHight-ledCaseHight+0.8]);
        }
    } /* backplate */
} /* module */
