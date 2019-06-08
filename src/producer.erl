-module(producer).

%% API exports
-export([start/2]).

start(ProducerId, BufferPid) ->
    io:format("[producer] #~p started ~n", [ProducerId]),
    produce(ProducerId, BufferPid).

produce(ProducerId, BufferPid) ->
    io:format("[producer] #~p working ~n", [ProducerId]),
    Time = rand:uniform(5) * 1000,
    timer:sleep(Time),
    BufferPid ! {ProducerId, Time, self()},
    produce(ProducerId, BufferPid).
