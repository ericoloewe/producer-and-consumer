-module(buffer).

%% API exports
-export([start/0]).

start() ->
    io:format("[buffer] started ~n"), manage([], []).

manage(Consumers, Products) ->
    receive
      {ConsumerId, PID} ->
	  io:format("[buffer] receive consumer: ~p ~p ~n",
		    [ConsumerId, PID]),
	  manage(Consumers ++ [PID], Products);
      {ProducerId, Product, PID} ->
	  io:format("[buffer] receive producer: ~p ~p ~p ~n",
		    [ProducerId, Product, PID]),
	  manage(Consumers, Products ++ [Product])
    end.
