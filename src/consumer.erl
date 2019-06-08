-module(consumer).

%% API exports
-export([consumer/2]).

consumer(ConsumerId, BufferPid) ->
    io:format("- consumer #~p started~n", [ConsumerId]).
