$fn=30;

/* debug variables */
grafixComp=1; //mm ; add 1 millimeter

/* Variables */
chamberElementsX=11; //letters in x direction
chamberElementsY=10; //letters in y direction
squareShape = true; //true to keep case in a square shape (not rectangular!)
ccubeSize = 13; //mm /* size of the cube elements */
caseHight=7; //mm
borderThickness=2; //mm
bottomThickness=2; //mm ; keep this. It's enougth

useAbsLength=true;
absoluteLengthX=170; //mm
absoluteLengthY=170; //mm

cableHole=true; // with cable holes
dCableHole=2; //mm


/* Passepartout */
additionalBorder=false;  /* enable passepartout */
additionalBorderLength=10; //mm /* passepartout */

module wClockCase(chamberElementsX=10, chamberElementsY=10,
        ccubeSize=10, squareShape=true,
        caseHight=10, borderThickness=2, bottomThickness=2,
        useAbsLength=false, absoluteLengthX=180, absoluteLengthY=180,
        cableHole=true, longHole=true, dCableHole=2,
        additionalBorder=false, additionalBorderLength=10){

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

    /* Model: case which should hold leds in chambers */
    difference() {
        cube([caseSizeX+addX,caseSizeY+addY,caseHight]);
        /* shift cutout cubes into middle */
        translate([borderShiftX,borderShiftY,0]){
            for(x=[0:chamberElementsX-1],
                y=[0:chamberElementsY-1]){
                translate([(x*(ccubeSize+borderThickness)),
                    (y*(ccubeSize+borderThickness))]){
                    /* generate cutout cubes */
                    translate([borderThickness,
                        borderThickness,
                        bottomThickness])
                    cube([ccubeSize,
                        ccubeSize,
                        cubeHight]);

                    if(cableHole && !longHole){  /* generate cable holes */
                        translate([ccubeSize+borderThickness/2,
                            ccubeSize-borderThickness-borderThickness/2,
                            bottomThickness/2])
                        cube([dCableHole,dCableHole,hCableHole],center=true);
                    } /* generate small cable holes */
                    if(cableHole && longHole){
                        translate([borderThickness+dCableHole/2,
                            borderThickness+ccubeSize/2,
                            bottomThickness/2])
                        cube([dCableHole,ccubeSize/2,hCableHole],center=true);
                    } /* generate long cable holes */
                } /* place inner cubes */
            } /* for */
        } /* translate all inner cubes */
    } /* difference */
} /* module */


wClockCase(chamberElementsX=11, chamberElementsY=10,ccubeSize=14,borderThickness=2, dCableHole=2);
