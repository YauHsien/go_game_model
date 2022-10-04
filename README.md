# go_game_model
. . . a project for proof of concept to build a Go game board.

### Module `go_game_board`

- set_go_board(+Width): to build a Go game board with Ki.

- print_ki_board: to inspect the Go game board represented with Ki.

Example:
```Prolog
?- go_game_board:set_go_board(3)
true.

?- go_game_board:print_ki_board.
232
343
232
true.
```
