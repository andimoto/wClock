
module wClockBack(chamberElementsX=11, chamberElementsY=10,
        ccubeSize=10, ledCaseHight=10, squareShape=true,
        borderThickness=2, bottomThickness=2,
        useAbsLength=false, absoluteLengthX=180, absoluteLengthY=180,
        additionalBorder=false, additionalBorderLength=10,
        buttons=true, screws=true, screwHight=10){

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

edgePillar=10; //mm

    translate([-(borderThickness+0.25),
        -(borderThickness+0.25),0]){
    difference(){
    union(){
        cube([caseSizeX+addX+borderThickness*2+0.5,
            caseSizeY+addY+borderThickness*2+0.5,
            bottomThickness]);

        translate([borderThickness+0.25,
            borderThickness+0.25,0]){
            /* cube([caseSizeX+addX,
                caseSizeY+addY,bottomThickness*2]); */
            cube([caseSizeX+addX,
                caseSizeY+addY,cubeHight-ledCaseHight+0.8]);
            }
        } /* union */

        /* edge pillars */
        translate([borderThickness+edgePillar,
            borderThickness,bottomThickness])
            cube([caseSizeX-edgePillar*2,
            caseSizeY+1,cubeHight-ledCaseHight+0.8]);
        translate([borderThickness,
            borderThickness+edgePillar,bottomThickness])
            cube([caseSizeX+1,
            caseSizeY-edgePillar*2,cubeHight-ledCaseHight+0.8]);

        /* holes for case screws */
        rotate([0,90,0])
        translate([-bottomThickness-screwHight,edgePillar/2+2.25,2])
        cylinder(r=1.6,h=caseSizeX+addX+0.5);

        rotate([0,90,0])
        translate([-bottomThickness-screwHight,
          caseSizeX-edgePillar+
          edgePillar/2+2.25,
          2])
        cylinder(r=1.6,h=caseSizeX+addX+0.5);

        /* Button #1 */
        if(buttons==true) translate([(caseSizeX+addX)/3+borderThickness+0.5,
            (caseSizeY+addY)-((caseSizeY+addY)/10)])
        cylinder(r=10.5, h=5, center=true);
        /* Button #2 */
        if(buttons==true) translate([(caseSizeX+addX)-(caseSizeX+addX)/3+borderThickness+0.5,
            (caseSizeY+addY)-((caseSizeY+addY)/10)])
        cylinder(r=10.5, h=5, center=true);
        /* Button #3 */
        if(buttons==true) translate([(caseSizeX+addX)/2+borderThickness+0.5,
            (caseSizeY+addY)-((caseSizeY+addY)/4)])
        cylinder(r=10.5, h=5, center=true);

        /* hole for mini/micro usb */
        translate([(caseSizeX+addX)/2+borderThickness+0.5,
          ((caseSizeY+addY)/10),-1])
        cube([12,10,7],center=true);

        /* wallmount */
        translate([(caseSizeX+addX)/2+borderThickness+0.5,
            (caseSizeY+addY)-((caseSizeY+addY)/20),-1])
        cube([3,3,6],center=true);

        }
    } /* backplate */
} /* module */
