-module(producer_and_consumer).

%% API exports
-export([main/0]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main() ->
    io:format("- main started~n"),
    BufferPid = spawn(buffer, buffer, []),
    ProducerPid = spawn(producer, producer, [1, BufferPid]),
    ConsumerPid = spawn(consumer, consumer, [1, BufferPid]),
    io:format("PIDS: [~p,~p,~p]~n",
	      [BufferPid, ProducerPid, ConsumerPid]).

%%====================================================================
%% Internal functions
%%====================================================================

