-module(consumer).

%% API exports
-export([start/2]).

start(ConsumerId, BufferPid) ->
    io:format("[consumer] #~p started ~n", [ConsumerId]),
    BufferPid ! {ConsumerId, self()}.
