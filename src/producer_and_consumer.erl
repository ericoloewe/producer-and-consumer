-module(producer_and_consumer).

%% API exports
-export([main/0, main/1]).

%% escript Entry point
main() -> main(10, 10).

main(Args) ->
    io:format("[main] started with args ~p ~n", [Args]),
    main().

main(NumberOfConsumers, NumberOfProducers) ->
    io:format("[main] started"),
    BufferPid = spawn(buffer, start, []),
    createConsumers(NumberOfConsumers, BufferPid),
    createProducers(NumberOfProducers, BufferPid).

createConsumer(Index, NumberOfConsumers, BufferPid) ->
    TimeToConsume = rand:uniform(NumberOfConsumers) * 1000,
    spawn(consumer, start,
	  [Index, BufferPid, TimeToConsume]).

createConsumers(NumberOfConsumers, BufferPid) ->
    spawn(fun () ->
		  lists:foreach(fun (Index) ->
					createConsumer(Index, NumberOfConsumers,
						       BufferPid)
				end,
				lists:seq(1, NumberOfConsumers))
	  end).

createProducer(Index, NumberOfProducers, BufferPid) ->
    TimeToProduce = rand:uniform(NumberOfProducers) * 1000,
    spawn(producer, start,
	  [Index, BufferPid, TimeToProduce]).

createProducers(NumberOfProducers, BufferPid) ->
    spawn(fun () ->
		  lists:foreach(fun (Index) ->
					createProducer(Index, NumberOfProducers,
						       BufferPid)
				end,
				lists:seq(1, NumberOfProducers))
	  end).
