-module(consumer).

%% API exports
-export([consumer/1]).

consumer(ConsumerId) ->
    io:format("- consumer #~p started~n", [ConsumerId]).
