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

createConsumers(NumberOfConsumers, BufferPid) ->
    spawn(fun () ->
		  lists:foreach(fun (Index) ->
					spawn(consumer, start,
					      [Index, BufferPid])
				end,
				lists:seq(1, NumberOfConsumers))
	  end).

createProducers(NumberOfProducers, BufferPid) ->
    spawn(fun () ->
		  lists:foreach(fun (Index) ->
					spawn(producer, start,
					      [Index, BufferPid])
				end,
				lists:seq(1, NumberOfProducers))
	  end).
