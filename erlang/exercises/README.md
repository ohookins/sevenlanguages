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
