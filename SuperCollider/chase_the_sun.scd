// First define our synth with adjustable parameters
(
SynthDef(\chaseSun, {
    arg freq=440, amp=0.5, cutoff=2000, res=0.3,
        drive=1.0, attack=0.05, release=0.2,
        detune=1.01, detuneAmp=0.5;

    var sig, env;

    // Simple envelope
    env = EnvGen.kr(
        Env.perc(attack, release),
        doneAction: 2
    );

    // Two oscillators with detune for thickness
    sig = Mix([
        Saw.ar(freq),
        Saw.ar(freq * detune) * detuneAmp
    ]);

    // Filter section
    sig = RLPF.ar(
        sig * drive,
        cutoff.clip(20, 20000),
        res
    );

    // Basic saturation
    sig = (sig * drive).tanh;

    Out.ar(0, sig * env * amp ! 2);
}).add;
)

// Define the melody sequence
(
// Notes in the melody (A4 to E5 sequence)
~notes = [
    69,  // A4
    76,  // E5
    76,  // E5
    74,  // D5
    72,  // C5
    71,  // B4
    71,  // B4
    72,  // C5
    71,  // B4
    69,  // A4
    67,  // G4
    64,  // E4
    67,  // G4
    69,  // A4
    71,  // B4
    69,  // A4
    \rest,
    \rest,
    \rest
];

// Duration for each note (adjust these to match the rhythm)
~durs = Array.fill(~notes.size, 0.25);  // 16th notes as base duration
// Add some longer notes where needed
~durs[0] = 0.5;  // rest
~durs[1] = 0.5;  // rest
~durs[5] = 0.75;  // rest
~durs[9] = 0.5;  // rest
~durs[10] = 0.75;  // rest
~durs[14] = 0.5;  // rest
~durs[15] = 1.5;  // rest

// Create the pattern
~pattern = Pbind(
    \instrument, \chaseSun,
    \midinote, Pseq(~notes, inf),
    \dur, Pseq(~durs, inf),
    \amp, 0.4,
    \cutoff, 2000,
    \res, 0.3,
    \drive, 1.2,
    \attack, 0.05,
    \release, 0.2,
    \detune, 1.01,
    \detuneAmp, 0.5
).play;
)

// Adjust parameters while playing
~pattern.set(\cutoff, 1000);
~pattern.set(\res, 3);
~pattern.set(\drive, 1.5);
~pattern.set(\detune, 1.02);
~pattern.set(\amp, 0.3);

// Stop the pattern
~pattern.stop;