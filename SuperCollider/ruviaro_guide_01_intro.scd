// Hello WOrld to console
"Hello World".postln;

// Play simple sine wave
{SinOsc.ar}.play;

// Generate volume GUI in new window
s.volume.gui;

// Sine wave in both channels LR (single wave defaults to L only)
{[SinOsc.ar, SinOsc.ar]}.play;

// Sine wave with LFO effects
{SinOsc.ar(LFNoise0.kr(10).range(200, 1200), mul: 0.1)}.play;

// Various effects, from a guide, not pedagogically very useful and I'm going to pass over them for now
{RLPF.ar(Dust.ar([1, 5]), LFNoise1.ar([1, 2]).range(100, 3000), 0.02)}.play;

// Evaluation is always L>R, regardless of operator
(5 + 2 * 2).postln; // = 14, not 9

// Lines 1, 2, 3 and 5 appear in the console. The last line evaluated in a single execution is always posted again. (Try executing with lines 5 or 6 as final evaluated line)
"First Line".postln;
"Second Line".postln;
(2 + 2).postln;
3 + 3;
"Finished".postln;
3 + 3;

// Put code in a block to evaluate the entire block from anywhere within it with Ctrl+Enter
(
// A little poem
"Today is Sunday".postln;
"Foot of pipe".postln;
"The pipe is made of gold".postln;
"It can beat the bull".postln;
)

// Use do to loop a command
100.do({"Print this line over and over...".scramble.postln});

// QUICK RECORD
// Start recording:
s.record;
// Make some cool sound
{Saw.ar(LFNoise0.kr([2, 3]).range(100, 2000), LFPulse.kr([4, 5]) * 0.1)}.play;
// Stop recording:
s.stopRecording;
// Optional: GUI with record button, volume control, mute button:
s.makeWindow;