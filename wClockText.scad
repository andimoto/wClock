use <fonts/Archicoco/Archicoco.otf>
use <fonts/kill_all_fonts/KillAllFonts.TTF>
use <fonts/Marske.otf>
use <fonts/major_shift.ttf>
use <fonts/major_shift3D.ttf>
use <fonts/major_shift3D_02.ttf>
use <fonts/ruler_stencil/RulerStencilBold.ttf>
use <fonts/ruler_stencil/RulerStencilHeavy.ttf>
include <wClockCase.scad>

ClockFontMarske="Marsh:style=Stencil";
ClockFontMajorShift="Major Snafu:style=Regular";
ClockFontMajorShift3D="Major Snafu:style=3D";
ClockFontMajorShift3D01="Major Snafu:style=3D\\_02";
ClockFontArchicoco="Archicoco:style=Regular";
ClockFontKillfonts="Kill All Fonts:style=Regular";
ClockFontRulerBold="Ruler Stencil:style=Fett";
ClockFontRulerHeavy="Ruler Stencil Heavy:style=Standard";
ClockFont=ClockFontMajorShift3D01;

grafixComp=1; //mm ; add 1 millimeter





module wClockText(chamberElementsX=11, chamberElementsY=10,
        ccubeSize=10, squareShape=true,
        caseHight=10, borderThickness=2, bottomThickness=2,
        useAbsLength=false, absoluteLengthX=180, absoluteLengthY=180,
        additionalBorder=false, additionalBorderLength=10){

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
            correctionX=-3;
            correctionY=1.2;
            translate([(ccubeSize)+addX*0.6+correctionX,
                    (((ccubeSize+borderThickness)*chamberElementsY)
                        +borderThickness)+addY*0.6+correctionY,
                        caseHight*3-bottomThickness])
            union(){
            for(i = [0:wClockRows-1],
                j = [0:wClockLines-1]){
                #translate([i*(ccubeSize+borderThickness),
                    -j*(ccubeSize+borderThickness),-grafixComp/2])
                    linear_extrude(height=bottomThickness+grafixComp)
                    text(wClockText[j][i],
                    font=ClockFont,
                    size = ccubeSize*0.7,
                    halign = "center",
                    valign = "center",
                    $fn = 10);
                }
            }
        }
    }
}

X=11;
Y=10;
cubeSize=13;
absLenX=250;
absLenY=250;
absLen=false;
borderThick=2;
bottom=2;

wClockText(chamberElementsX=X,
    chamberElementsY=Y,
    ccubeSize=cubeSize, squareShape=true,
    useAbsLength=absLen, absoluteLengthX=absLenX, absoluteLengthY=absLenY,
    borderThickness=borderThick, bottomThickness=bottom);

/*translate([0,0,22])*/{
    /* #wClockCase(chamberElementsX=X,
            chamberElementsY=Y,
            ccubeSize=cubeSize, caseHight=10, useAbsLength=absLen,
            absoluteLengthX=absLenX, absoluteLengthY=absLenY,
            borderThickness=borderThick, bottomThickness=bottom,
            dCableHole=2); */
    }

    /* caseHight=10, borderThickness=2, bottomThickness=2,
    useAbsLength=false, absoluteLengthX=180, absoluteLengthY=180,
    additionalBorder=false, additionalBorderLength=10 */
