caseThickness=2; //mm
chamberElementSize=10; //mm
chamberElementsX=11;
chamberElementsY=10;
caseSizeX=caseThickness+
    (chamberElementSize+caseThickness)*chamberElementsX;
caseSizeY=caseThickness+
    (chamberElementSize+caseThickness)*chamberElementsY;
difference() {
    #cube([caseSizeX,caseSizeY,10]);
    for(x=[0:chamberElementsX-1],
        y=[0:chamberElementsY-1]){
    translate([(x*(chamberElementSize+caseThickness)),
        (y*(chamberElementSize+caseThickness))]){
    translate([caseThickness,caseThickness,caseThickness])
        cube([chamberElementSize,
            chamberElementSize,
            chamberElementSize+1-caseThickness]);
            translate([chamberElementSize/3+caseThickness,
            chamberElementSize/3+caseThickness])
            cylinder(r=1.5, h=5, center=true);
    }}

}
