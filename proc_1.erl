-module(proc_1).
-export([init/0,proc_loop/1]).

% simplified inter-process communication and process state

% spawn process, start the loop to feed it new values
init() ->
    LoopPid = spawn_link(proc_1, proc_loop, [[]]),
    num_loop(LoopPid).

% this loop feeds numbers
num_loop(Pid) ->
    timer:sleep(5000),
    Pid ! {newValue, random:uniform(9999)},
    num_loop(Pid).

% this loop is the spawned process; waiting for new values,
% printing state and new values as they arrive
proc_loop(Values) ->
    io:format("Values: "),
    lists:map(fun(X) -> io:format("~p ",[X]) end, Values),
    io:format("~n"),
    receive
        {newValue, X} ->
            io:format(">> Received new value: ~p~n", [X]),
            proc_loop([X|Values])
    after
        2000 ->
            proc_loop(Values)
    end.
