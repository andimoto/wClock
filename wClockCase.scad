/* debug variables */
grafixComp=1; //mm ; add 1 millimeter

/* Variables */
absoluteLength=160; //mm
borderThickness=2; //mm
bottomThickness=2; //mm ; keep this. It's enougth
rCableHole=2; //mm
hCableHole=bottomThickness+grafixComp;
chamberElementsX=11+2; //letters in x direction + 1 second light on each side
chamberElementsY=10+2; //letters in y direction + 1 second light on each side
caseHight=10; //mm
/* should be higher due to see
the cubes over the case surface */
cubeHight=caseHight-bottomThickness+grafixComp;


chamberSize = ((absoluteLength - borderThickness) /
    (chamberElementsX)) - borderThickness;
echo("Cutout Cube Size:",chamberSize,"mm");

/* because elements in X & Y direction are not equal,
   all cutout cubes have to be shifted into the middle */
borderShiftY= (absoluteLength -
        ((chamberSize+borderThickness)
        *chamberElementsY) - borderThickness)/2;

echo("Shift in Y Direction: ",borderShiftY);


/* Model: case which should hold leds in chambers */
difference() {
    #cube([absoluteLength,absoluteLength,caseHight]);
    translate([0,borderShiftY,0]){
    for(x=[0:chamberElementsX-1],
        y=[0:chamberElementsY-1]){
        translate([(x*(chamberSize+borderThickness)),
            (y*(chamberSize+borderThickness))]){
            /* cutout cubes */
            translate([borderThickness,borderThickness,bottomThickness])
            cube([chamberSize,
                chamberSize,
                cubeHight]);

            /* cable holes */
            translate([chamberSize/3+borderThickness,
            chamberSize/2+borderThickness,bottomThickness/2])
            cylinder(r=rCableHole, h=hCableHole, center=true);
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
