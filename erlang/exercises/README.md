## Instructions for running
### monitored translate service
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
