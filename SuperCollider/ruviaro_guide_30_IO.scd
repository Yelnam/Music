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

