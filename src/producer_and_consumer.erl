-module(producer_and_consumer).

%% API exports
-export([main/0]).

%% escript Entry point
main() ->
    io:format("[main] started"),
    BufferPid = spawn(buffer, start, []),
    ConsumerPid = spawn(consumer, start, [1, BufferPid]),
    ProducerPid = spawn(producer, start, [1, BufferPid]),
    io:format("[main] PIDS => [~p,~p,~p]",
	      [BufferPid, ProducerPid, ConsumerPid]).
