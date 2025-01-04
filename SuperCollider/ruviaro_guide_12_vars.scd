// vars
x = 10;
y = 660;
x + y;

a = "Hello, World";
b = [0, 1, 2, 3, 5];
c = Pbind(\note, Pwhite(0, 10), \dur, 0.1); // you'll learn all about Pbind later, don't worry

a.postln;
b + 100;
c.play;
d = b * 5;

// use tilda for vars with names longer than char
~myFreqs = [415, 220, 440, 880, 220, 990];
~myDurs = [0.1, 0.2, 0.2, 0.5, 0.2, 0.1];

Pbind(\freq, Pseq(~myFreqs), \dur, Pseq(~myDurs)).play;

// Environment variables
~galaApples = 4;
~bloodOranges = 5;
~limes = 2;
~plantains = 1;

["Citrus", ~bloodOranges + ~limes];
["Non−citrus", ~plantains + ~galaApples];

// Local variables: valid only within the code block.
// Evaluate the block once and watch the Post window:
(
var apples = 4, oranges = 3, lemons = 8, bananas = 10;
["Citrus fruits", oranges + lemons].postln;
["Non−citrus fruits", bananas + apples].postln;
"End".postln;
)

~galaApples; // still

c = 5;
c = c + 1;
c.postln;