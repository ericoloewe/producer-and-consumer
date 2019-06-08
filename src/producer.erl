-module(producer).

%% API exports
-export([producer/1]).

producer(ProducerId) ->
    io:format("- producer #~p started~n", [ProducerId]).
