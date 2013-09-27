% Start like this:
% otp_supervisor:start_link()

-module(otp_supervisor).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link(?MODULE, []).

init(_Args) ->
    {ok, {{one_for_one, 1, 60},
        [{otp_logger, {otp_logger, start_link, []},
            permanent, brutal_kill, worker, [otp_logger]}]}}.
