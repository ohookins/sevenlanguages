-module(doctor_watcher).
-export([start/0, watcher/0]).

start() ->
    io:format("Starting the monitored doctor service.~n"),
    register(watcher, spawn(fun watcher/0)).

watcher() ->
    process_flag(trap_exit, true),
    Pid = spawn(fun doctor:loop/0),
    monitor(process, Pid),
    register(doctor, Pid),
    doctor ! new,
    receive
        {'DOWN', _Ref, process, Pid2, Reason} ->
            io:format("Doctor (~p), died (~p), restarting it.~n", [Pid2, Reason]),
            watcher()
        end.
