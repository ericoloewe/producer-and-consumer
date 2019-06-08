-module(buffer).

%% API exports
-export([start/0]).

start() ->
    io:format("[buffer] started ~n"),
    receive
      {ConsumerId, PID} ->
	  io:format("[buffer] receive consumer: ~p ~p ~n",
		    [ConsumerId, PID]);
      {ProducerId, Product, PID} ->
	  io:format("[buffer] receive producer: ~p ~p ~p ~n",
		    [ProducerId, Product, PID])
    end.
