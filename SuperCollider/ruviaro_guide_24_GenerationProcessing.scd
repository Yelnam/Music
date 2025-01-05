// create a virtual theremin
// freq self explanatory. mul = amplitude multiplier
// mouse movements control freq and amp/mul
{SinOsc.ar(freq: MouseX.kr(300, 2500), mul: MouseY.kr(0, 1))}.play;

// plot waves to visualise them
{ SinOsc.ar }.plot; // sine wave
{ Saw.ar }.plot; // sawtooth wave
{ Pulse.ar }.plot; // square wave

// swap in Saw and Pulse on theremin
{Saw.ar(freq: MouseX.kr(0, 450), mul: MouseY.kr(0, 1))}.play;
{Pulse.ar(freq: MouseX.kr(0, 540), mul: MouseY.kr(0, 1))}.play;

// use polling to inspect outputs at intervals in Post window (control signals with no sound)
{SinOsc.kr(1).poll}.play;
{LFPulse.kr(1).poll}.play;


s.volume.gui
{LFNoise0.ar(1).poll}.play; // numeric arg = clicks/sec

// default and specified arg orders

// minval and maxval provided in order, no keywords
{MouseX.kr(300, 2500).poll}.play;
// minval, maxval and lag provided, skipped warp
{MouseX.kr(minval: 300, maxval: 2500, lag: 10).poll}.play;


//scaling ranges

// .range takes a Ugen output (-1 .. 1) and rescales it
{SinOsc.ar(freq: LFNoise0.kr(10).range(500, 1500), mul: 0.1)}.play;

{LFNoise0.kr(1).poll}.play; // watch a simple LFNoise0 in action
{LFNoise0.kr(1).range(500, 1500).poll}.play; // now with .range
{LFNoise0.kr(10).range(500, 1500).poll}.play; // now faster

// exercise: create a LFPule-controlled sin
// !2 doubles the output and puts it in both channels
{SinOsc.ar(freq: LFPulse.kr(100).range(240, 300)) !2}.play;

// using mul and add

// each pair of paired lines below are equivalent
// multiply 2 (-1, 1) and shift up y-axis
{SinOsc.kr(1).range(100, 200).poll}.play;
{SinOsc.kr(1, mul: 50, add: 150).poll}.play;

// multiply 1 (0, 1) and shift up y-axis
{LFPulse.kr(1).range(100, 200).poll}.play;
{LFPulse.kr(1, mul: 100, add: 100).poll}.play;

// linear and exponential scaling

a = [1, 2, 3, 4, 5, 6, 7];
// rescale to 0−127, linear to linear
a.linlin(1, 7, 0, 127).round(1);
// rescale to 0−127, linear to exponential
a.linexp(1, 7, 0.01, 127).round(1); // avoid 0 for exp

// stopping synths individually

a = { Saw.ar(LFNoise2.kr(8).range(1000, 2000), mul: 0.2) }.play;
b = { Saw.ar(LFNoise2.kr(7).range(100, 1000), mul: 0.2) }.play;
c = { Saw.ar(LFNoise0.kr(15).range(2000, 3000), mul: 0.1) }.play;
a.free;
b.free;
c.free;

// use set to update params in real time

x = {arg freq = 440, amp = 0.1; SinOsc.ar(freq, 0, amp)}.play;
x.set(\freq, 778);
x.set(\amp, 0.5);
x.set(\freq, 920, \amp, 0.2);
x.free;

