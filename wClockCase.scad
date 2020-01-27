/* debug variables */
grafixComp=1; //mm ; add 1 millimeter

/* Variables */
absoluteLengthX=180; //mm
absoluteLengthY=180; //mm
additionalBorder=false;  /* enable passepartout */
additionalBorderLength=10; //mm /* passepartout */
ccubeSize = 15; //mm /* size of the cube elements */
caseHight=10; //mm
borderThickness=2; //mm
bottomThickness=2; //mm ; keep this. It's enougth
cableHole=true; // with cable holes
rCableHole=2; //mm
hCableHole=bottomThickness+grafixComp;
chamberElementsX=11; //letters in x direction
chamberElementsY=10; //letters in y direction

/* should be higher due to see
the cubes over the case surface */
cubeHight=caseHight-bottomThickness+grafixComp;

/* calculate longest side of case
to get a square case with similar lengths */
caseSizeMin = (chamberElementsX < chamberElementsY) ?
    ((chamberElementsY *
        (ccubeSize + borderThickness)) + borderThickness) :
    ((chamberElementsX *
        (ccubeSize + borderThickness)) + borderThickness);
echo("Total Case Size:",caseSizeMin,"mm");


caseSize= (additionalBorder) ? (caseSizeMin+additionalBorderLength):caseSizeMin;


/* because elements in X & Y direction are not equal,
   all cutout cubes have to be shifted into the middle */
borderShiftX= (caseSize -
       ((ccubeSize+borderThickness)
       *chamberElementsX) - borderThickness)/2;

borderShiftY= (caseSize -
        ((ccubeSize+borderThickness)
        *chamberElementsY) - borderThickness)/2;

echo("Shift in X Direction: ",borderShiftX);
echo("Shift in Y Direction: ",borderShiftY);


/* Model: case which should hold leds in chambers */
difference() {
    #cube([caseSize,caseSize,caseHight]);
    /* shift cutout cubes into middle */
    translate([borderShiftX,borderShiftY,0]){
    for(x=[0:chamberElementsX-1],
        y=[0:chamberElementsY-1]){
        translate([(x*(ccubeSize+borderThickness)),
            (y*(ccubeSize+borderThickness))]){
            /* generate cutout cubes */
            translate([borderThickness,borderThickness,bottomThickness])
            cube([ccubeSize,
                ccubeSize,
                cubeHight]);

            if(cableHole){
                /* generate cable holes */
                translate([ccubeSize/3+borderThickness,
                ccubeSize/2+borderThickness,bottomThickness/2])
                cylinder(r=rCableHole, h=hCableHole, center=true);
            }
        }
    }
    }
}

//module wordPlate(){
//plateShift = absoluteLength - (absoluteLength-(borderThickness/2));
//translate([/*absoluteLength+10*/-plateShift,-plateShift,10])
//cube([absoluteLength+borderThickness,absoluteLength+borderThickness,borderThickness]);
//}

/* #wordPlate(); */
