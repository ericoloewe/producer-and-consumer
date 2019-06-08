-module(consumer).

%% API exports
-export([start/2]).

start(ConsumerId, BufferPid) ->
    io:format("[consumer] #~p started ~n", [ConsumerId]),
    listenBufferAndConsume(ConsumerId, BufferPid).

listenBufferAndConsume(ConsumerId, BufferPid) ->
    BufferPid ! {ConsumerId, self()},
    receive
      Product ->
	  io:format("[consumer] receive: ~p ~n", [Product]),
	  Time = rand:uniform(5) * 1000,
	  timer:sleep(Time),
	  listenBufferAndConsume(ConsumerId, BufferPid)
    end.
