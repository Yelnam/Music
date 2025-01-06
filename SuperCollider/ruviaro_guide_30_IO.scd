// routing

// left channel
{Out.ar(0, SinOsc.ar(440, 0, 0.1))}.play;
// right channel
{Out.ar(1, SinOsc.ar(440, 0, 0.1))}.play;

// band pass filter on any sound passed to bus 55
f = {Out.ar(0, BPF.ar(in: In.ar(55), freq: MouseY.kr(1000, 5000), rq: 0.1))}.play;
// send a white noise signal to bus 55
n = {Out.ar(55, WhiteNoise.ar(0.5))}.play;

// note that the first line here (like prev examples)
// actually does the second under the hood
{SinOsc.ar(440)}.play
{Out.ar(0, SinOsc.ar(440))}.play

// 31 mic input

{SoundIn.ar(0)}.play; // takes sound from 1st input bus
{SoundIn.ar([0, 1])}.play; // stereo
//with reverb
{FreeVerb.ar(SoundIn.ar([0, 1]), mix: 0.5, room: 0.9)}.play;

// 32 multi-channel expansion

// any time an arg expects a unique value and is passed an array, the entire patch is duplicated
{Out.ar(0, Saw.ar(freq: [440, 550], mul: Line.kr(0, 0.75, 3)))}.play;

// arrays are pattern matched so that e.g.
// the left channel here is given a pulse freq of 2hz, the right channel 3hz
a = {Out.ar(0, SinOsc.ar(freq: [400, 500], mul: LFPulse.ar([2,3])))}.play;
a.free;

// 33 the Bus object

// the Bus object is useful because it allows us to abstract away the assigning and tracking of bus numbers

// run this first to turn reverb on
// (55,2) means two adjacent buses starting at 55
//    we set this because we know the b object will
//    take up two bus slots
r = {Out.ar(0, FreeVerb.ar(In.ar(55, 2), mix: 0.5, room: 0.9, mul: 0.4))}.play;

// now run this to the tone into the reverb bus
b = {Out.ar(55, SinOsc.ar([800, 880], mul: LFPulse.ar(2)))}.play;
b.free;

// to simplify bus assigment... create a Bus
// (s, 2) = server, n of channels
~myBus = Bus.audio(s, 2);
// turn on the reverb: read from myBus
r = {Out.ar(0, FreeVerb.ar(In.ar(~myBus, 2), mix: 0.5, room: 0.9, mul: 0.4))}.play;
// feed the busy tone into ~myBus
c = {Out.ar(~myBus, SinOsc.ar([800, 880], mul: LFPulse.ar(2)))}.play;
// Free both synths
r.free; c.free;

// 34 panning

p = {Pan2.ar(in: PinkNoise.ar, pos: SinOsc.kr(11), level: 0.1)}.play;
p.free;

(
x = {
var lfn = LFNoise2.kr(15);
	var saw = Saw.ar(
		freq: 120,
		mul: LFPulse.kr(freq: LFNoise1.kr(5).range(0.5, 5), width: 0.1));
	var bpf = BPF.ar(
		in: saw,
		freq: lfn.range(500, 2500),
		rq: 0.01,
		mul:25);
	Pan2.ar(in: bpf, pos: lfn);
}.play;
)
x.free;

// 35 splay and mix

// 5 channels output (watch Meter window)
a = { SinOsc.ar([100, 300, 500, 700, 900], mul: 0.1) }.play;
a.free;
// Mix it down to mono:
b = { Mix(SinOsc.ar([100, 300, 500, 700, 900], mul: 0.1)) }.play;
b.free;
// Mix it down to stereo (spread evenly from left to right)
c = { Splay.ar(SinOsc.ar([100, 300, 500, 700, 900], mul: 0.1)) }.play;
c.free

// Fun with Splay:
(
d = {arg fundamental = 110;
var harmonics = [1, 2, 3, 4, 5, 6, 7, 8, 9];
var snd = BPF.ar(
in: Saw.ar(32, LFPulse.ar(harmonics, width: 0.1)),
freq: harmonics * fundamental,
rq: 0.01,
mul: 20);
Splay.ar(snd); // mixes down nine channels to stereo
}.play;
)

d.set(\fundamental, 50); // change fundamental just for fun
d.free;

// instant cluster generator
// (16) different randomly initialised sins played simul
c = { Mix.fill(16, {SinOsc.ar(rrand(100, 3000), mul: 0.01)}) }.play;
c.free;

// A note with 12 partials of decreasing amplitudes
(
n = { Mix.fill(12, {arg counter;
var partial = counter + 1; // we want it to start from 1, not 0
SinOsc.ar(partial * 440, mul: 1/partial.squared) * 0.1
})
}.play;
FreqScope.new;
)
n.free;