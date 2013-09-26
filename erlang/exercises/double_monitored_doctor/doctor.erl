-module(doctor).
-export([loop/1]).

loop(Pid) ->
    process_flag(trap_exit, true),
    receive
        new ->
            io:format("Creating and monitoring process.~n"),
            Pid2 = spawn_link(fun roulette:loop/0),
            register(revolver, Pid2),
            loop(Pid2);
        die ->
            io:format("Doctor is about to die!~n"),
            exit(arghhhh);
        {'EXIT', From, Reason} ->
            case From of
                Pid ->
                    io:format("The shooter ~p died with reason ~p.", [From, Reason]),
			        io:format(" Restarting. ~n"),
                    self() ! new,
                    loop(nopid);
                _ ->
                    io:format("The watcher ~p died with reason ~p.", [From, Reason]),
                    io:format(" Restarting.~n"),
                    register(watcher, spawn_link(doctor_watcher, watcher, [no_doctor])),
                    loop(Pid)
            end
        end.
