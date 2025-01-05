[1, 2, 3, "wow"].reverse;
"hello".dup(4);
3.1415.round(0.1);
100.rand; // evaluates to a diff value up to 100 each time
100.0.rand.round(0.01).dup(4); // chaining messages

5.dup(20); // receiver notation
dup(5, 20); // same thing in functional notation

3.1415.round(0.1); // receiver notation
round(3.1415, 0.1); // functional notation

// nesting
round(sort(dup({exprand(1.0, 1000.0)}, 100)), 0.01);

// if / else
(
a = 100.0.rand;
a.postln;
if(a > 50, { "very true".postln }, { "very false".postln });
)

// case
2 (
3 ~num = ;
4
5 case
6 {~num == 0} {"WOW".postln}
7 {~num == 1} {"ONE!".postln}
8 {~num < 0} {"negative number!".postln}
9 {true}
)

// define a function
f = { 2 + 2 }; // define the function
f.value; // put the function to work

// and another
f = {arg a, b; ["a plus b", a+b, "a times b", a*b].postln}; // define function
f.value(3, 7); // now you can give any two numbers as arguments to the function
f.value(10, 14);

// compare:
~sillyRand = rrand(0, 10); // not a function
~sillyRand.value; // evaluate several times
~sillyRand2 = {rrand(0, 10)}; // a function
~sillyRand2.value; // evaluate several times

(
~whatToDo = {
var today, dayName, actions;
today = Date.getDate.dayOfWeek;
dayName =
case
{today==0} {"Sunday"}
{today==1} {"Monday"}
{today==2} {"Tuesday"}
{today==3} {"Wednesday"}
{today==4} {"Thursday"}
{today==5} {"Friday"}
{today==6} {"Saturday"};
actions = ["boomerang throwing", "arm wrestling", "stair climbing", "
playing chess", "underwater hockey", "pea shooting", "a nap marathon"];
"Ah, " ++ dayName ++ "...! " ++ "What a good day for " ++ actions.choose;
};
)

// Run it in the morning
~whatToDo.value;