-module(producer_and_consumer).

%% API imports
-import(producer, [producer/1]).

-import(consumer, [consumer/1]).

-import(buffer, [buffer/0]).

%% API exports
-export([main/0]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main() ->
    io:format("- main started~n"),
    buffer(),
    producer(1),
    consumer(1),
    erlang:halt(0).

%%====================================================================
%% Internal functions
%%====================================================================

