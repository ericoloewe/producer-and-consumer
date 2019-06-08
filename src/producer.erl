-module(producer).

%% API exports
-export([producer/2]).

producer(ProducerId, BufferPid) ->
    io:format("- producer #~p started~n", [ProducerId]).
