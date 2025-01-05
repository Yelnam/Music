// Create some array
a = [10, 11, 12, 13, 14, 15, 16, 17];
a.reverse; // reverse
a.scramble; // scramble
a.choose; // picks one element at random
a.size; // returns size of array
a.at(0); // retrieves item at specified position
a[0] ; // same as above
a.wrapAt(9); // retrieves item at specified position, wrapping around if > a.size
["wow", 99] ++ a; // concatenates the two arrays into a new one
a ++ \hi; // a Symbol is a single character
a ++ 'hi'; // same as above
a ++ "hi"; // a String is a collection of characters
a.add(44); // creates new array with new element at the end
a.insert(5, "wow"); // inserts "wow" at position 5, pushes other items forward (returns new array)
a; // evaluate this and see that none of the above operations actually changed the original array
a.put(2, "oops"); // put "oops" at index 2 (destructive; evaluate line above again to check)
a.permute(3); // permute: item in position 3 goes to position 0, and vice−versa
a.mirror; // makes it a palindrome
a.powerset; // returns all possible combinations of the array's elements

// array math

[1, 2, 3, 4, 5] + 10;
[1, 2, 3, 4, 5] * 10;
([1, 2, 3, 4, 5] / 7).round(0.01); // parentheses for precedence
x = 11; y = 12;
[x, y, 9] * 100;
// operations differ depending on types
[1, 2, 3, 4, "oops", 11] + 10;

// initializing arrays

// Arithmetic series
Array.series(size: 6, start: 10, step: 3);
// Geometric series
Array.geom(size: 10, start: 1, grow: 2);
// Compare the two:
Array.series(7, 100, −10);
Array.geom(7, 100, 0.9);

Array.fill(10, "same");
Array.fill(10, rrand(1, 10));
Array.fill(10, {rrand(1, 10)});
// name counter is arbitrary
Array.fill(10, {arg counter; counter * 10});
// generate a harmonic series
Array.fill(10, {arg wow; wow+1 * 440});
// create an empty array of given size
a = Array.newClear(7);
a[3] = "wow"; // same as a.put(3, "wow")

// ! shortcut notation:

30!4;
"hello" ! 10;
// are equivalent to...
30.dup(4);
"hello".dup(10);
// or
Array.fill(4, 30);
Array.fill(10, "hello");

// ranged arrays

(50..79);
// same as...
series(50, 51, 79);
// or...
Array.series(30, 50, 1);
// from step other than 1, do e.g.
(50, 53 .. 79);
// same result as:
series(50, 53, 79);
Array.series(10, 50, 3);

// use "do" to map a function over an array

~myFreqs = Array.fill(10, {rrand(440, 880)});
// takes current item and index/count as default args
~myFreqs.do({arg item, count; ("Item " ++ count ++ " is " ++ item ++ " Hz. Closest midinote is " ++ item.cpsmidi.round).postln});

// if you don't need the counter, just use one argument:
~myFreqs.do({arg item; {SinOsc.ar(item, 0, 0.1)}.play});
~myFreqs.do({arg item; item.squared.postln});
// same as...
~myFreqs.squared; // probably syntactic sugar anyway
