% http://www.erlang.org/doc/design_principles/sup_princ.html
% Start like this:
% translate_sup:start_link()

-module(translate_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link(?MODULE, []).

init(_Args) ->
    {ok, {{one_for_one, 1, 60},
        [{translate_otp, {translate_otp, start_link, []},
            permanent, brutal_kill, worker, [translate_otp]}]}}.
