(
a = { SinOsc.ar([100, 300, 500, 700, 900], mul: 0.1) }.play;

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
d.free;