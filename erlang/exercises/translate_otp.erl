% These are good resources for this task:
% http://blog.bot.co.za/en/article/349/an-erlang-otp-tutorial-for-beginners
% http://www.erlang.org/doc/design_principles/gen_server_concepts.html
% http://www.erlang.org/doc/man/gen_server.html
% http://www.erlang.org/doc/design_principles/des_princ.html
% http://www.erlang.org/doc/reference_manual/processes.html

-module(translate_otp).
-behaviour(gen_server).
-define(SERVER, ?MODULE).
-record(state, {count}).

-export([start_link/0]).
-export([translate/1, get_count/0, stop/0]).
-export([init/1, handle_call/3, handle_cast/2, terminate/2, handle_info/2, code_change/3]).

% API function definitions
start_link() ->
    gen_server:start_link(
        {local, ?SERVER},
        ?MODULE, [],
        []).

translate(Word) ->
    gen_server:call(?SERVER, {translate, Word}).

get_count() ->
    gen_server:call(?SERVER, get_count).

stop() ->
    gen_server:cast(?SERVER, stop).

% gen_server callbacks
init([]) ->
    {ok, #state{count=0}}.

handle_call({translate, Word}, _From, State) ->
    Count = element(2,State) + 1,
    case Word of
        "casa" ->
            Reply = "house";
        "blanca" ->
            Reply = "white";
        _ ->
            Reply = "I don't understand."
    end,
    {reply, Reply, #state{count=Count}};

handle_call(get_count, _From, State) ->
    Count = element(2, State) + 1,
    {reply, Count, #state{count=Count}}.

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
