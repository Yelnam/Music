Pbind(\degree, Pseries(0, 1, 30), \dur, 0.05).play;

// Degree 0 = middle C
Pbind(\degree, 0).play;

Pbind(\degree, 0, \dur, 0.5).play;

// Degrees are zero-indexed, which is weird
Pbind(\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7], 1), \dur, 0.2).play;

// NB durations will loop early due to shorter sequence
Pbind(\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7], 5), \dur, Pseq([0.2, 0.1, 0.1, 0.2, 0.2, 0.35], inf)).play;

// As above, better formatting
(
Pbind(
	\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7], 5),
	\dur, Pseq([0.2, 0.1, 0.1, 0.2, 0.2, 0.35], inf)
).play;
)

// Use note rather than degree to get all 12 tones
Pbind(\note, Pseq([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 1), \dur, 0.1).play;

// 0r use midi numbers
Pbind(\midinote, Pseq([60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72], 1), \dur, 0.1).play;

// 0r use Hz
Pbind(\freq, Pseq([440, 523, 660, 784], 4), \dur, 0.15).play;

// Use amplitude & legato
(
Pbind(
\degree, Pseq([0, 1, 2, 3, 4, 5, 7, 9, 4, 2, 0, −2], 4),
\dur, Pseq([0.2, 0.1, 0.2, 0.1], inf),
\amp, Pseq([1, 0.5, 1, 0.5], inf),
\legato, 0.43
).play;
)

// rand picks a rand item from list on each loop
(
Pbind(
\degree, Prand([2, 3, 4, 5, 6], inf),
\dur, 0.15,
\amp, 0.2,
\legato, 0.1
).play;
)

// white uses lower and upper bounds on a distribution
// use integers for discrete distributions or
// floats for ~continuous
(
Pbind(
\freq, Pwhite(100, 500),
\dur, Prand([0.15, 0.25, 0.3], inf),
\amp, 0.2,
\legato, 0.3
).trace.play; //uses trace to output data to console
)

// Pser, 2nd arg gives no. of notes rather than reps
(
Pbind(
\note, Pser([0, 2, 3, 5, 7, 8, 11, 12], 11),
\dur, 0.15;
).play;
)

// Pxrand avoids repeating notes
(
p = Pbind(
\note, Pxrand([0, 2, 3, 5, 7, 8, 11, 12], inf),
\dur, 0.15;
).play;
)

// Pshuf shuffles the notes ONCE then repeats
(
p = Pbind(
\note, Pshuf([0, 2, 3, 5, 7, 8, 11, 12], 6),
\dur, 0.15;
).play;
)

// Pslide
// Takes 4 arguments: list, repeats, length, step
(
Pbind(
\note, Pslide([0, 2, 3, 5, 7, 8, 11, 12], 7, 3, 1),
\dur, 0.15;
).play;
)

// Pseries
// Takes three arguments: start, step, length
(
Pbind(
\note, Pseries(0, 2, 15),
\dur, 0.15;
).play;
)

// Pgeom
// Takes three arguments: start, grow, length
(
Pbind(
\note, Pseq([0, 2, 3, 5, 7, 8, 11, 12], inf),
\dur, Pgeom(0.1, 1.1, 25);
).play;
)
// Pn (play note) takes note and no. of reps as args
(
Pbind(
\note, Pseq([0, Pn(2, 3), 3, Pn(5, 3), 7, Pn(8, 3), 11, 12], 1),
\dur, 0.15;
).play;
)