-module(otp_logger).
-behaviour(gen_server).
-define(SERVER, ?MODULE).

-export([start_link/0]).
-export([log/1, stop/0]).
-export([init/1, handle_call/3, handle_cast/2, terminate/2, handle_info/2, code_change/3]).

% API function definitions
start_link() ->
    gen_server:start_link(
        {local, ?SERVER},
        ?MODULE, [],
        []).

log(Message) ->
    gen_server:cast(?SERVER, {log, Message}).

stop() ->
    gen_server:cast(?SERVER, stop).

% gen_server callbacks
init([]) ->
    % open the log file
    {Status, Result} = file:open('output.log', write),
    case Status of
        ok ->
            io:format("Opened log file for appending.~n");
        _ ->
            io:format("Error (~p) opening log file: ~p~n", [Status, Result]),
            exit(failed)
    end,
    {ok, Result}.

handle_call(_Request, _From, State) ->
    {noreply, State}.

handle_cast({log, Message}, Io) ->
    % log the message
    io:format(Io, "[~p]: ~s~n", [now(), Message]),
    {noreply, Io};

handle_cast(stop, State) ->
    {stop, normal, State}.

handle_info(Info, State) ->
    error_logger:info_msg("~p~n", [Info]),
    {noreply, State}.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

terminate(_Reason, _State) ->
    error_logger:info_msg("terminating~n"),
    ok.
