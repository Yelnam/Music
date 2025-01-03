// Set master volume (0.0 to 1.0)
s.volume = -10;  // in dB

// Define a simple synth with lots of tweakable parameters
(
SynthDef(\tweakable, {
    arg freq=440, cutoff=1000, res=0.2,
        drive=1.0, lfoRate=0.5, lfoAmount=0,
        osc2Detune=1.01, osc2Mix=0.5;

    var sig, lfo;

    // LFO for filter modulation
    lfo = SinOsc.kr(lfoRate) * lfoAmount;

    // Two oscillators with detune
    sig = Mix([
        Saw.ar(freq),
        Saw.ar(freq * osc2Detune) * osc2Mix
    ]);

    // Filter with modulation
    sig = RLPF.ar(
        sig * drive,
        (cutoff + (lfo * 1000)).clip(20, 20000),
        res
    );

    // Basic saturation
    sig = (sig * drive).tanh;

	// Multiply the final output by amp
    Out.ar(0, (sig * amp) ! 2);

}).add;
)

// Start the synth
x = Synth(\tweakable);

// Now you can tweak any parameter in real-time:

// Change the base frequency
x.set(\freq, 110);

// Adjust the filter
x.set(\cutoff, 4000);
x.set(\res, 0.3);

// Add some drive
x.set(\drive, 0.8);

// Adjust the LFO
x.set(\lfoRate, 1);  // Faster modulation
x.set(\lfoAmount, 0.1);  // More pronounced modulation

// Modify the second oscillator
x.set(\osc2Detune, 1.5);  // More detuned
x.set(\osc2Mix, 0.7);  // Louder second oscillator

x.set(\amp, 0.2);  // Lower volume

// Stop the synth
x.free;