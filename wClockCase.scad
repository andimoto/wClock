$fn=50;
borderThickness=2; //mm
chamberElementSize=10; //mm
chamberElementsX=11;
chamberElementsY=10;
caseSizeX=borderThickness+
    (chamberElementSize+borderThickness)*chamberElementsX;
caseSizeY=borderThickness+
    (chamberElementSize+borderThickness)*chamberElementsY;
difference() {
    #cube([caseSizeX,caseSizeY,10]);
    for(x=[0:chamberElementsX-1],
        y=[0:chamberElementsY-1]){
    translate([(x*(chamberElementSize+borderThickness)),
        (y*(chamberElementSize+borderThickness))]){
    translate([borderThickness,borderThickness,borderThickness])
        cube([chamberElementSize,
            chamberElementSize,
            chamberElementSize+1-borderThickness]);
            translate([chamberElementSize/3+borderThickness,
            chamberElementSize/3+borderThickness])
            cylinder(r=1.5, h=5, center=true);
    }}

}
