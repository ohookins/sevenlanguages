-module(day2).
-export([key_to_value/2, shopping_list/1, tictactoe/1]).

% day2:key_to_value/2
key_to_value(List, Keyword) -> [Value || {Key,Value} <- List, Key == Keyword].

% day2:shopping_list/2
shopping_list(List) -> [{Item, Quantity * Price} || {Item, Quantity, Price} <- List].

% day2:tictactoe/1
% Takes a tuple/9 with o, x or ' ' (for an empty cell) representing the board.
% e.g.: tictactoe({o,o,o,' ',x,' ',x,' ',x}).
tictactoe(Board) ->
    if
        tuple_size(Board) /= 9 -> throw("Require a tuple of 9 elements");
        true -> true
    end,

    case Board of
        {X,X,X,_,_,_,_,_,_} when X /= ' ' -> X;
        {_,_,_,X,X,X,_,_,_} when X /= ' ' -> X;
        {_,_,_,_,_,_,X,X,X} when X /= ' ' -> X;
        {X,_,_,X,_,_,X,_,_} when X /= ' ' -> X;
        {_,X,_,_,X,_,_,X,_} when X /= ' ' -> X;
        {_,_,X,_,_,X,_,_,X} when X /= ' ' -> X;
        {X,_,_,_,X,_,_,_,X} when X /= ' ' -> X;
        {_,_,X,_,X,_,X,_,_} when X /= ' ' -> X;
        _ -> available_moves(Board)
    end.

% available_moves/1 returns cat if there are no more possible moves,
% and no_winner if no player has won yet.
available_moves(Board) ->
    case any_cells_empty(Board, 0) of
        false -> cat;
        true -> no_winner
    end.

% check_cell/2 returns true if cell Index in Board or any subsequent cells
% contain an available space.
any_cells_empty(Board, Index) ->
    if
        Index >= tuple_size(Board) -> false;
        element(Index, Board) == ' ' -> true;
        true -> any_cells_empty(Board, Index + 1)
    end.
