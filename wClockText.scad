use <glasten-bold.ttf>
use <aldo.ttf>
use <major-snafu.ttf>
use <octin-stencil-free.ttf>
use <technique-brk.ttf>

ClockFont="Technique BRK:style=Normal";

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
difference(){
    translate([0,-120,0])
    #cube([120,120,2]);
    translate([10,-15,0])
    union(){
    for(i = [0:wClockLines-1],
        j = [0:wClockRows-1]){
        /* echo(wClockText[i][j]); */
        /* echo(i,j); */
        translate([j*10,-i*10,-1])
        linear_extrude(height = 4)
        text(wClockText[i][j],
        font=ClockFont,
        size = 5,
        halign = "center",
        valign = "center",
        $fn = 10);
        }
    }
}
