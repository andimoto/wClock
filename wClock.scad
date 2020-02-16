include <wClockLedCase.scad>
include <wClockTextCase.scad>
include <wClockBack.scad>

X=11;
Y=11;
cubeSize=14;
absLenX=250;
absLenY=250;
absLen=false;
borderThick=2;
bottom=2;
caseHight=40;
ledCaseHight=10;

textCorrectionX=-3;
textCorrectionY=-7;

difference(){
union(){
    translate([-(borderThick+0.25),
      -(borderThick+0.25),borderThick])
    color("lightgrey")
    wClockTextCase(chamberElementsX=X,
        chamberElementsY=Y,
        correctionX=textCorrectionX,
        correctionY=textCorrectionY,
        ccubeSize=cubeSize, squareShape=true, caseHight=caseHight,
        useAbsLength=absLen, absoluteLengthX=absLenX, absoluteLengthY=absLenY,
        borderThickness=borderThick, bottomThickness=bottom,
        screws=true, screwHight=10);


    wClockBack(chamberElementsX=X, chamberElementsY=Y,
            ccubeSize=cubeSize, ledCaseHight=10, squareShape=true,
            borderThickness=borderThick, bottomThickness=bottom,
            useAbsLength=absLen, absoluteLengthX=absLenX, absoluteLengthY=absLenY,
            additionalBorder=false, additionalBorderLength=borderThick,
            buttons=true, screws=true, screwHight=10 );

    translate([0,0,caseHight-ledCaseHight])
    color("plum")
    wClockLedCase(chamberElementsX=X,
            chamberElementsY=Y,
            ccubeSize=cubeSize, caseHight=ledCaseHight, useAbsLength=absLen,
            absoluteLengthX=absLenX, absoluteLengthY=absLenY,
            borderThickness=borderThick, bottomThickness=bottom,
            dCableHole=2);
}/*union*/
/* translate([-10,-10,-10]){cube([200,20,60]);} */
}
