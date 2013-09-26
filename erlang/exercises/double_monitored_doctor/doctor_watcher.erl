-module(doctor_watcher).
-export([start/0, watcher/1]).

start() ->
    io:format("Starting the monitored doctor service.~n"),
    register(watcher, spawn(?MODULE, watcher, [start_doctor])).

watcher(Init) ->
    process_flag(trap_exit, true),
    io:format("Init: ~p~n",[Init]),
    case Init of
        start_doctor ->
            io:format("Starting fresh doctor.~n"),
            register(doctor, spawn_link(doctor, loop, [nopid])),
            doctor ! new;
        _ ->
            io:format("Starting fresh watcher.~n")
    end,
    receive
        {'EXIT', From, Reason} ->
            io:format("Doctor (~p), died (~p), restarting it.~n", [From, Reason]),
            watcher(start_doctor);
        die ->
            exit(arghhh)
        end.
