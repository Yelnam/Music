// SECTION 1: SynthDef --1
(
SynthDef(\modDemo, {
    arg freq=440, amp=0.5,
        lfoRate=1, lfoDepth=100,
        modFunc=0, modRate=1, modDepth=100,
        cutoff=1000, res=0.3;

    var sig, lfo, customMod;

    lfo = SinOsc.kr(lfoRate) * lfoDepth;

    customMod = Select.kr(modFunc, [
        LFPulse.kr(modRate) * modDepth,    // 0: Square
        LFTri.kr(modRate) * modDepth,      // 1: Triangle
        LFNoise0.kr(modRate) * modDepth,   // 2: Random steps
        LFNoise1.kr(modRate) * modDepth,   // 3: Smooth random
        LFPar.kr(modRate) * modDepth       // 4: Exponential
    ]);

    sig = Mix([
        Saw.ar(freq + lfo + customMod),
        Saw.ar(freq * 1.01 + lfo + customMod)
    ]);

    sig = RLPF.ar(
        sig,
        (cutoff + (lfo * 0.5)).clip(20, 20000),
        res
    );

    Out.ar(0, sig * amp ! 2);
}).add;
)

// SECTION 2: Initialize Control Functions --2
(
// Store synth in environment variable
~synth = nil;

// Start synth
~startSynth = {
    if(~synth.isNil, {
        ~synth = Synth(\modDemo);
        "Synth started".postln;
    }, {
        "Synth is already running".postln;
    });
};

// Stop synth
~stopSynth = {
    if(~synth.notNil, {
        ~synth.free;
        ~synth = nil;
        "Synth stopped".postln;
    }, {
        "No synth is running".postln;
    });
};

// Modulation presets
~simpleLFO = {
    if(~synth.notNil, {
        ~synth.set(\lfoRate, 2, \lfoDepth, 50, \modDepth, 0);
        "Simple LFO mode".postln;
    }, {
        "Start the synth first (Alt+P)".postln;
    });
};

~squareWave = {
    if(~synth.notNil, {
        ~synth.set(\modFunc, 0, \modRate, 4, \modDepth, 30, \lfoDepth, 0);
        "Square wave mode".postln;
    }, {
        "Start the synth first (Alt+P)".postln;
    });
};

~randomSteps = {
    if(~synth.notNil, {
        ~synth.set(\modFunc, 2, \modRate, 8, \modDepth, 20);
        "Random steps mode".postln;
    }, {
        "Start the synth first (Alt+P)".postln;
    });
};

~combined = {
    if(~synth.notNil, {
        ~synth.set(\lfoDepth, 30, \modDepth, 20, \modFunc, 2);
        "Combined modulation mode".postln;
    }, {
        "Start the synth first (Alt+P)".postln;
    });
};
)

// SECTION 3: Set Up Key Bindings --3
(
// Remove any existing key bindings
KeyCodeActions.clear;

// Function key codes for F1-F8
var f1 = 0xF704;
var f2 = 0xF705;
var f3 = 0xF706;
var f4 = 0xF707;
var f5 = 0xF708;
var f6 = 0xF709;

// Start/Stop
KeyCodeActions.at(f1, false, false, false, { ~startSynth.value });  // F1 to play
KeyCodeActions.at(f2, false, false, false, { ~stopSynth.value });   // F2 to terminate

// Modulation modes
KeyCodeActions.at(f3, false, false, false, { ~simpleLFO.value });   // F3 for LFO
KeyCodeActions.at(f4, false, false, false, { ~squareWave.value });  // F4 for square
KeyCodeActions.at(f5, false, false, false, { ~randomSteps.value }); // F5 for random
KeyCodeActions.at(f6, false, false, false, { ~combined.value });    // F6 for combined

"Key bindings set up:
 F1 : Play (start synth)
 F2 : Terminate (stop synth)
 F3 : Simple LFO mode
 F4 : Square wave mode
 F5 : Random steps mode
 F6 : Combined mode".postln;
)

// SECTION 4: Quick Parameter Adjustments --4
// Run these lines individually as needed
~synth.set(\freq, 220);        // Change base frequency
~synth.set(\cutoff, 2000);     // Adjust filter cutoff
~synth.set(\res, 0.7);         // Adjust resonance
~synth.set(\amp, 0.3);         // Adjust volume