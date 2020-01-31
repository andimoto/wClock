use <glasten-bold.ttf>
use <aldo.ttf>
use <major-snafu.ttf>
use <octin-stencil-free.ttf>
use <technique-brk.ttf>
include <wClockCase.scad>

ClockFontGlasten="Glasten:style=Bold"; /* ok */
ClockFontOctin="Octin Stencil Free:style=Regular"; /*good!*/
ClockFont=ClockFontOctin;

grafixComp=1; //mm ; add 1 millimeter

/* Variables */
chamberElementsX=11; //letters in x direction
chamberElementsY=10; //letters in y direction
squareShape = true; //true to keep case in a square shape (not rectangular!)
ccubeSize = 20; //mm /* size of the cube elements */
caseHight=10; //mm
borderThickness=2; //mm
bottomThickness=2; //mm ; keep this. It's enougth

useAbsLength=false;
absoluteLengthX=170; //mm
absoluteLengthY=170; //mm

cableHole=true; // with cable holes
dCableHole=2; //mm


/* Passepartout */
additionalBorder=false;  /* enable passepartout */
additionalBorderLength=10; //mm /* passepartout */

/* translate([0,0,(caseHight*2)-bottomThickness]){
wClockCase(chamberElementsX=11,
        chamberElementsY=10,
        ccubeSize=20,
        borderThickness=2, dCableHole=2);
} */

wClockLines=10;
wClockRows=11;
wClockText=[
    ["E","S","K","I","S","T","L","F","Ü","N","F"],
    ["Z","E","H","N","Z","W","A","N","Z","I","G"],
    ["D","R","E","I","V","I","E","R","T","E","L"],
    ["T","G","N","A","C","H","V","O","R","J","M"],
    ["H","A","L","B","O","Z","W","Ö","L","F","P"],
    ["Z","W","E","I","N","S","I","E","B","E","N"],
    ["K","D","R","E","I","R","H","F","Ü","N","F"],
    ["E","L","F","N","E","U","N","V","I","E","R"],
    ["W","A","C","H","T","Z","E","H","N","R","S"],
    ["B","S","E","C","H","S","F","M","U","H","R"]
];

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

echo("Shift in X Direction: ",borderShiftX);
echo("Shift in Y Direction: ",borderShiftY);

/* rotate([0,$t*360,0]) */
translate([-(borderThickness+0.25),
    -(borderThickness+0.25),0]){
difference(){
    cube([caseSizeX+addX+borderThickness*2+0.5,
        caseSizeY+addY+borderThickness*2+0.5,caseHight*3]);
    translate([borderThickness,
        borderThickness,-0.1]){
        cube([caseSizeX+addX+0.5,
            caseSizeY+addY+0.5,(caseHight*3)-bottomThickness+0.1]);
        }
    /* position of letters */
    translate([ccubeSize-ccubeSize/3,
        ((ccubeSize+borderThickness)*chamberElementsY)
        +borderThickness/2,caseHight*3-bottomThickness])
    #union(){
    for(i = [0:wClockLines-1],
        j = [0:wClockRows-1]){
        translate([j*(ccubeSize+borderThickness),
            -i*(ccubeSize+borderThickness),0])
            linear_extrude(height = bottomThickness)
            text(wClockText[i][j],
            font=ClockFont,
            size = ccubeSize*0.7,
            halign = "center",
            valign = "center",
            $fn = 10);
        }
    }
}


}
