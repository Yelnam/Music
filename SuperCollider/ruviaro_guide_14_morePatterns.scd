// Chords
(
Pbind(
\note, Pseq([[0, 3, 7], [2, 5, 8], [3, 7, 10], [5, 8, 12]], 3),
\dur, 0.5
).play;
)

// Fun with strum
(
Pbind(
\note, Pseq([[2, 3, 7, 10], [0, 3, 5, 8]], 2),
\dur, 1,
\legato, 0.4,
\strum, 0.1 // try 0, 0.1, 0.2, etc
).play;
)

// degree assumes a Major scale, but you can specify
(
Pbind(
\scale, Scale.harmonicMinor,
\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7], 1),
\dur, 0.15;
).play;
)

(
Pbind(
\scale, Scale.mixolydian,
\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7], 1),
\dur, 0.15;
).play;
)

(
Pbind(
\scale, Scale.spanish,
\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7], 1),
\dur, 0.15;
).play;
)

// Evaluate this line to see a list of all available scales:
Scale.directory;

// for a chromatic note in between scale degrees, add 0.1:
(
Pbind(
\degree, Pseq([0, 1, 2, 3, 3.1, 4], 1),
\dur, 0.15;
).play;
)

// transpose by semitones on all note types but \freq
(
Pbind(
\note, Pser([0, 2, 3, 5, 7, 8, 11, 12], 11),
\ctranspose, -5, // transpose +n semitones
\dur, 0.15;
).play;
)

// Microtones with \note and \midinote:
Pbind(\note, Pseq([0, 0.5, 1, 1.5, 1.75, 2], 1)).play;

(
Pbind(
\midinote, Pseq([60, 60.1, 60.2, 60.3, 60.4, 60.5, 60.6,60.7,60.8,60.9,61,73,61,73], 1),
\dur, 0.15;
).play;
)


// add a TempoClock to set tempo, default 60bpm
(
Pbind(\degree, Pseq([0, 0.1, 1, 2, 3, 4, 5, 6, 7]),
\dur, 1; // 1 beat at n bpm
).play(TempoClock(120/60)); // beats per sec
)

// rests

(
Pbind(
\degree, Pwhite(0, 7),
\dur, Pseq([0.5, 0.5, Rest(0.5), 0.5], inf);
).play;
)


( // multiple Pbinds in block for simultaneous execution
Pbind(
\freq, Pn(Pseries(110, 111, 10)),
\dur, 1/2,
\legato, Pwhite(0.1, 1)
).play;

Pbind(
\freq, Pn(Pseries(220, 222, 10)),
\dur, 1/4,
\legato, Pwhite(0.1, 1)
).play;

Pbind(
\freq, Pn(Pseries(330, 333, 10)),
\dur, 1/6,
\legato, 0.1
).play;
) // close big block

// use wait inside a .fork block to apply waits
(
{
"one thing".postln;
2.wait;
"another thing".postln;
1.5.wait;
"one last thing".postln;
}.fork;
)

// A more interesting example:
(
t = TempoClock(76/60);
{
Pbind(
\note, Pseq([[4, 11], [6, 9]], 32),
\dur, 1/6,
\amp, Pseq([0.05, 0.03], inf)
).play(t);

2.wait;

Pbind(
\note, Pseq([[−25, −13, −1], [−20, −8, 4], \rest], 3),
\dur, Pseq([1, 1, Rest(1)], inf),
\amp, 0.1,
\legato, Pseq([0.4, 0.7, \rest], inf)
).play(t);

2.75.wait;

Pbind(
\note, Pseq([23, 21, 25, 23, 21, 20, 18, 16, 20, 21, 23, 21],
inf),
\dur, Pseq([0.25, 0.75, 0.25, 1.75, 0.125, 0.125, 0.80, 0.20,
0.125, 0.125, 1], 1),
\amp, 0.1,
\legato, 0.5
).play(t);
}.fork(t);
)

// Ppar
(
var a, b;
a = Pbind(\note, Pseq([7, 4, 0], 4), \dur, Pseq([1, 0.5, 1.5], inf));
b = Pbind(\note, Pseq([5, 10, 12], 4), \dur, 1);
Ppar([ a, b ]).play;
)

// Pspawner
(
// create 6 streams at 4 second intervals
// then delete them in the order they were created

Pspawner({ | sp |
    var streams, stream;
    // start patterns, collect the resultant event streams
    streams = [2, 3, 4, 6, 7, 8].collect { | i |
        stream = sp.par(Pbind(*[
            harmonic: i,
            ctranspose:     [0, 1, 3]/40,
            octave:    Pbrown(2,8,2), dur: 1/i, db: -30
        ]) );
        sp.wait(4);
        stream;
    };

    // now stop those streams one by one
    streams.do { | s | sp.suspend(s); sp.wait(4) };
}).play
)

// using transforms on var lists
~scale = [0, 1, 2, 3, 4, 5, 6, 7];
~durs = [0.4, 0.2, 0.2, 0.4, 0.8, 0.2, 0.2, 0.2];
(
Pbind(
\degree, Pseq(~scale),
\dur, Pseq(~durs)
).play;

Pbind(
\degree, Pseq(~scale.reverse + 7),
\dur, Pseq(~durs)
).play;
)


// book describes this as Assignment to multiple keys
// assume the means key as in key/value rather than musical key
// book is pretty poorly written, and this isn't clear
(
Pbind(
#[midinote, dur], Pseq([
[60, 0.75],
[67, 0.25]
], inf),
\amp, 0.7
).play;
)

































