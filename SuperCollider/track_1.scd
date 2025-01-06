(
a = { SinOsc.ar([100, 300, 500, 700, 900], mul: 0.1) }.play;

b = {SinOsc.ar(SinOsc.kr(0.5, phase: pi/2, mul: 38 * 0.68, add: 38), mul: 0.3) !2}.play;

(
d = {arg fundamental = 50;
	var harmonics = [1, 2, 3, 4, 5, 6, 7, 8, 9];
	var snd = BPF.ar(
		in: Saw.ar(32, LFPulse.ar(harmonics, width: 0.1)),
		freq: harmonics * fundamental,
		rq: 0.01,
		mul: 20);
	Splay.ar(snd);
}.play;
)
)

a.free;
b.free;
d.free;


