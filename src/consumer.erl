-module(consumer).

%% API exports
-export([start/3]).

start(ConsumerId, BufferPid, TimeToConsume) ->
    io:format("[consumer] #~p started ~n", [ConsumerId]),
    listenBufferAndConsume(ConsumerId, BufferPid,
			   TimeToConsume).

listenBufferAndConsume(ConsumerId, BufferPid,
		       TimeToConsume) ->
    BufferPid ! {ConsumerId, self()},
    receive
      Product ->
	  io:format("[consumer] receive: ~p ~n", [Product]),
	  timer:sleep(TimeToConsume),
	  listenBufferAndConsume(ConsumerId, BufferPid,
				 TimeToConsume)
    end.
