% Percent sign starts a one-line comment.

    % foo(Bar, Baz)
    %
    % Documentation comments are indented before what they describe.
:- pred foo(bar::in, baz::out) is det.

% All toplevel syntax elements end with a '.' -- a full stop.

% Mercury terminology comes from predicate logic. Very roughly:

% | Mercury               | C                            |
% |                       |                              |
% | Goal                  | statement                    |
% | expression            | expression                   |
% | predicate rule        | void function                |
% | function rule         | function                     |
% | head (of a rule)      | function name and parameters |
% | body (of a rule)      | function body                |
% | fact                  | (rule without a body)        |
% | pred/func declaration | function signature           |
% | A, B  (conjunction)   | A && B                       |
% | A ; B (disjunction)   | if (A) {} else if (B) {}     |

% some facts:
man(socrates).  % "it is a fact that Socrates is a man"
man(plato).
man(aristotle).

% a rule:
mortal(X) :- man(X).  % "It is a rule that X is a mortal if X is a man."
%            ^^^^^^-- the body of the rule
%         ^^-- an arrow <--, pointing to the head from the body
%^^^^^^^^-- the head of the rule
% this is also a single clause that defines the rule.

% that X is capitalized is how you know it's a variable.
% that socrates is uncapitalized is how you know it's a term.

% it's an error for 'socrates' to be undefined. It must have a type:

% declarations begin with ':-'
:- type people
    --->    socrates
    ;       plato
    ;       aristotle
    ;       hermes.
    %<--first tab stop (using 4-space tabs)
            %<--third tab stop (first after --->)

:- pred man(people).  % rules and facts also require types

% a rule's modes tell you how it can be used.
:- mode man(in) is semidet.  % man(plato) succeeds. man(hermes) fails.
:- mode man(out) is multi.   % man(X) binds X to one of socrates ; plato ; aristotle

% a semidet predicate is like a test. It doesn't return a value, but
% it can succeed or fail, triggering backtracking or the other side of
% a disjunction or conditional.

% 'is semidet' provides the determinism of a mode. Other determinisms:
% | Can fail? | 0 solutions | 1       | more than 1 |
% |           |             |         |             |
% | no        | erroneous   | det     | multi       |
% | yes       | failure     | semidet | nondet      |

:- pred mortal(people::in) is semidet.  % type/mode in one declaration

% this rule's body consists of two conjunctions: A, B, C
% this rule is true if A, B, and C are all true.
% if age(P) returns 16, it fails.
% if alive(P) fails, it fails.
:- type voter(people::in) is semidet.
voter(P) :-
    alive(P),
    registered(P, locale(P)),
    age(P) >= 18.  % age/1 is a function; int.>= is a function used as an operator

% "a P is a voter if it is alive, is registered in P's locale, and if
% P's age is 18 or older."

% the >= used here is provided by the 'int' module, which isn't
% imported by default. Mercury has a very small 'Prelude' (the
% 'builtin' module). You even need to import the 'list' module if
% you're going to use list literals.

