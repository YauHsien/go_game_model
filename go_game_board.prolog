:- module(go_game_board,
          [set_go_board/1,
           print_ki_board/0]).

put_ki(X-Y, K) :-
    assertz(ki(X-Y, K)).

update_ki(X-Y, K) :-
    ( current_predicate(ki/2), once(ki(X-Y, _)), !,
      retract(ki(X-Y, _))
    ; true
    ),
    put_ki(X-Y, K).

% To build a Go board by "Ki" elements.

update_board(W) :-
    retractall(ki(_, _)),
    ( current_predicate(board/1), !,
      retract(board(_))
    ; true
    ),
    asserta(board(W)).

assert_ki_elements(W) :-
    update_board(W),
    assert_ki_elements((0,0), W).

assert_ki_elements((0,W), W) :- !.
assert_ki_elements((W,Y), W) :-
    Y < W, !,
    Y1 is Y + 1,
    assert_ki_elements((0,Y1), W).
assert_ki_elements((X,Y), W) :-
    X < W, Y < W, !,
    ( ( X =:= 0, Y =:= 0, !
      ; X =:= W-1, Y =:= W-1, !
      ; X =:= 0, Y =:= W-1, !
      ; X =:= W-1, Y =:= 0
      ), !,
      K = 2
    ; ( X =:= 0, !
      ; X =:= W-1, !
      ; Y =:= 0, !
      ; Y =:= W-1
      ), !,
      K = 3
    ; K = 4
    ),
    put_ki(X-Y, K),
    X1 is X + 1,
    assert_ki_elements((X1,Y), W).

% / To build a Go board by "Ki" elements

set_go_board(W) :-
    assert_ki_elements(W).

print_ki_board :-
    board(W),
    foreach(
        ( between(1, W, Y),
          between(1, W, X),
          X0 is X - 1, Y0 is Y - 1,
          ki(X0-Y0, K)
        ),
        ( X =:= W,
          writeln(K)
        ; write(K)
        )).
