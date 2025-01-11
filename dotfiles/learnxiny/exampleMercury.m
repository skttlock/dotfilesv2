:- module types.
:- interface.
:- import_module io.  % required for io.io types in...
% main/2 is usually 'det'. threading and exceptions require 'cc_multi'
:- pred main(io::di, io::uo) is cc_multi.  % program entry point
:- implementation.
:- import_module int, float, string, list, bool, map, exception.

% enum.
:- type days
    --->    sunday
    ;       monday
    ;       tuesday
    ;       wednesday
    ;       thursday
    ;       friday
    ;       saturday.

% discriminated union, like datatype in ML.
:- type payment_method
    --->    cash(int)
    ;       credit_card(
                name :: string,         % named fields
                cc_number :: string,
                cvv :: int,
                expiration :: string
            )
    ;       crypto(coin_type, wallet, amount).

:- type coin_type
    --->    etherium
    ;       monero.  % "other coins are available"

% type aliases.
:- type wallet == string.
:- type amount == int.

% !IO is the pair of io.io arguments
% pass it to anything doing I/O, in order to perform I/O.
% many otherwise-impure functions can 'attach to the I/O state' by taking !IO
main(!IO) :-
    Ints = [
        3,
        1 + 1,
        8 - 1,
        10 * 2,
        35 / 5,
        5 / 2,      % truncating division
        int.div(5, 2),  % floored division
        div(5, 2),  % (module is unambiguous due to types)
        5 `div` 2,  % (any binary function can be an operator with ``)
        7 `mod` 3,  % modulo of floored division
        7 `rem` 3,  % remainder of truncating division
        2 `pow` 4,  % 2 to the 4th power
        (1 + 3) * 2,    % parens have their usual meaning

        2 >> 3,     % bitwise right shift
        128 << 3,   % bitwise left shift
        \ 0,        % bitwise complement
        5 /\ 1,     % bitwise and
        5 \/ 1,     % bitwise or
        5 `xor` 3,  % bitwise xor

        max_int,
        min_int,

        5 `min` 3,  % ( if 5 > 3 then 3 else 5 )
        5 `max` 3
    ],
    Bools = [
        yes,
        no
        % bools are much less important in Mercury because control flow goes by
        % semidet goals instead of boolean expressions.
    ],
    Strings = [
        "this is a string",
        "strings can have "" embedded doublequotes via doubling",
        "strings support \u4F60\u597D the usual escapes\n",
        % no implicit concatenation of strings: "concat:" "together"
        "but you can " ++ " use the string.++ operator",

        % second param is a list(string.poly_type)
        % s/1 is a function that takes a string and returns a poly_type
        % i/1 takes an int. f/1 takes a float. c/1 takes a char.
        string.format("Hello, %d'th %s\n", [i(45), s("World")])
    ],

    % start with purely functional types like 'map' and 'list'!
    % arrays and hash tables are available too, but using them
    % requires knowing a lot more about Mercury
    get_map1(Map1),
    get_map2(Map2),

    % list.foldl has *many* variations
    % this one calls io.print_line(X, !IO) for each X of the list
    foldl(io.print_line, Ints, !IO),
    foldl(io.print_line, Bools, !IO),
    foldl(io.print_line, Strings, !IO),
    io.print_line(Map1, !IO),
    % ( if Cond then ThenGoal else ElseGoal )
    % I/O not allowed in Cond: I/O isn't allowed to fail!
    ( if Map2^elem(42) = Elem then
        io.print_line(Elem, !IO)
    else % always required
        true  % do nothing, successfully (vs. 'fail')
    ),

    % exception handling:
    ( try [io(!IO)] ( % io/1 param required or no I/O allowed here
        io.print_line(received(cash(1234)), !IO),
        io.print_line(received(crypto(monero, "invalid", 123)), !IO)
    ) then
        io.write_string("all payments accepted\n", !IO) % never reached
    catch "monero not yet supported" -> % extremely specific catch!
        io.write_string("monero payment failed\n", !IO)
    ).

:- pred get_map1(map(string, int)::out) is det.
get_map1(!:Map) :-  % !:Map in the head is the final (free, unbound) Map
    !:Map = init,   % !:Map in the body is the next Map
    det_insert("hello", 1, !Map),  % pair of Map vars
    det_insert("world", 2, !Map),

    % debug print of current (bound) Map
    % other [Params] can make it optional per runtime or compiletime flags
    trace [io(!IO)] (io.print_line(!.Map, !IO)),

    det_insert_from_corresponding_lists(K, V, !Map),
    % this code is reordered so that K and V and defined prior to their use
    K = ["more", "words", "here"],
    V = [3, 4, 5].

:- pred get_map2(map(int, bool)::out) is det.
get_map2(Map) :-
    det_insert(42, yes, map.init, Map).

:- func received(payment_method) = string.
received(cash(N)) = string.format("received %d dollars", [i(N)]).
received(credit_card(_, _, _, _)) = "received credit card".  % _ is throwaway
received(crypto(Type, _Wallet, Amount)) = S :-  % _Wallet is named throwaway
    ( % case/switch structure
        Type = etherium,
        S = string.format("receiving %d ETH", [i(Amount)])
    ;
        Type = monero,
        throw("monero not yet supported")  % exception with string as payload
    ).
