## Instructions for running
### supervised translate service
This is a ```gen_server```-based module, which runs inside of a supervisor.

At the erlang shell:
```
% compile the modules
c(translate_otp).
c(translate_sup).

% start the supervisor of the translator service
translate_sup:start_link().

% use the exported API of the service
translate_otp:translate("blanca").
translate_otp:get_count().

% stop the service (which will cause the supervisor to restart it)
translate_otp:stop().
```

#### running it over the network
```
% start two instances of the Erlang VM in different terminals
erl -sname dilbert
erl -sname dogbert

% ensure you can reach one from the other using the full node name
net_adm:ping("dogbert@nodename").

% start the translate service running on one VM
translate_sup:start_link().

% send a string to translate using the RPC module of the other VM
rpc:call("dilbert@nodename", translate_otp, translate, ["blanca"]).
```

### monitored doctor
This is a one-way monitored version of the doctor/roulette system.

At the erlang shell:
```
% compile the modules
c(roulette).
c(doctor).
c(doctor_watcher).

% start the doctor watcher, which also starts the doctor and roulette game
doctor_watcher:start().

% shoot the revolver a few times, perhaps killing (and reviving) the player
revolver ! 1.
revolver ! 3.

% kill (and revive) the doctor
doctor ! die.
```

### double_monitored_doctor
This is the same doctor/roulette system, but with two-way monitoring between
the doctor and a watcher.

At the erlang shell:
```
% compile the modules
c(roulette).
c(doctor).
c(doctor_watcher).

% start the doctor watcher, which also starts the doctor and roulette game
doctor_watcher:start().

% shoot the revolver and kill (and revive) the player by the doctor
revolver ! 3.

% kill (and revive) the doctor by the watcher
doctor ! die.

% kill (and revive) the watcher by the doctor
watcher ! die.
```

### OTP-based logger
This is a gen_server-based OTP logger with an OTP supervisor. Logging is
performed asynchronously using gen_server:cast, and goes to a file called
output.log for this exercise code.

At the Erlang shell:
```
% compile the modules
c(otp_logger).
c(otp_supervisor).

% Start the supervisor and logger service
otp_supervisor:start_link().

% Send some log messages
otp_logger:log("this is a log message").
otp_logger:log("this is another log message").
```
