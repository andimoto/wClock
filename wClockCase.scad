/* Variables */
absoluteLength=130; //mm
borderThickness=2; //mm
chamberElementsX=11;
chamberElementsY=10;

chamberSize = ((absoluteLength - borderThickness) /
    (chamberElementsX)) - borderThickness;

/* because elements in X & Y direction are not equal,
   all cutout cubes have to be shifted into the middle */
borderShiftY= (absoluteLength -
        ((chamberSize+borderThickness)
        *chamberElementsY) - borderThickness)/2;


echo (chamberSize);

chamberElementSize=chamberSize; //mm

caseSizeX=borderThickness+
    (chamberElementSize+borderThickness)*chamberElementsX;
caseSizeY=borderThickness+
    (chamberElementSize+borderThickness)*chamberElementsY;

/* Model */
difference() {
    #cube([caseSizeX,caseSizeX,10]);
    translate([0,borderShiftY,0]){
    for(x=[0:chamberElementsX-1],
        y=[0:chamberElementsY-1]){
        translate([(x*(chamberElementSize+borderThickness)),
            (y*(chamberElementSize+borderThickness))]){
                /* cutout cubes */
            translate([borderThickness,borderThickness,borderThickness])
            cube([chamberElementSize,
                chamberElementSize,
                chamberElementSize+1-borderThickness]);

            /* cable holes */
            translate([chamberElementSize/3+borderThickness,
            chamberElementSize/3+borderThickness])
            cylinder(r=1.5, h=5, center=true);
        }
    }
}
}
