/* debug variables */
grafixComp=1; //mm ; add 1 millimeter

/* Variables */
absoluteLengthX=180; //mm
absoluteLengthY=180; //mm
caseHight=10; //mm
borderThickness=2; //mm
bottomThickness=2; //mm ; keep this. It's enougth
cableHole=true; // with cable holes
rCableHole=2; //mm
hCableHole=bottomThickness+grafixComp;
chamberElementsX=11; //letters in x direction + 1 second light on each side
chamberElementsY=10; //letters in y direction + 1 second light on each side
chambElemetsForSize = chamberElementsX; // default calculation with chamberElementsX

/* should be higher due to see
the cubes over the case surface */
cubeHight=caseHight-bottomThickness+grafixComp;


chamberSize = ((absoluteLengthX - borderThickness) /
    (chambElemetsForSize)) - borderThickness;
echo("Cutout Cube Size:",chamberSize,"mm");
echo("Cutout Cubes:",chambElemetsForSize);
/* because elements in X & Y direction are not equal,
   all cutout cubes have to be shifted into the middle */
borderShiftX= (absoluteLengthX -
       ((chamberSize+borderThickness)
       *chamberElementsX) - borderThickness)/2;

borderShiftY= (absoluteLengthY -
        ((chamberSize+borderThickness)
        *chamberElementsY) - borderThickness)/2;

echo("Shift in X Direction: ",borderShiftX);
echo("Shift in Y Direction: ",borderShiftY);


/* Model: case which should hold leds in chambers */
difference() {
    #cube([absoluteLengthX,absoluteLengthY,caseHight]);
    /* shift cutout cubes into middle */
    translate([borderShiftX,borderShiftY,0]){
    for(x=[0:chamberElementsX-1],
        y=[0:chamberElementsY-1]){
        translate([(x*(chamberSize+borderThickness)),
            (y*(chamberSize+borderThickness))]){
            /* cutout cubes */
            translate([borderThickness,borderThickness,bottomThickness])
            cube([chamberSize,
                chamberSize,
                cubeHight]);

            if(cableHole){
                /* cable holes */
                translate([chamberSize/3+borderThickness,
                chamberSize/2+borderThickness,bottomThickness/2])
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
