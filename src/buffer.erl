-module(buffer).

%% API exports
-export([start/0]).

start() ->
    io:format("[buffer] started ~n"), manage([], []).

manage(Consumers, Products) ->
    io:format("[buffer] managing: c=~p p=~p ~n",
	      [length(Consumers), length(Products)]),
    receive
      {ConsumerId, PID} ->
	  receiveConsumerAndKeepManaging(ConsumerId, PID,
					 Consumers, Products);
      {ProducerId, Product, PID} ->
	  receiveProductAndKeepManaging(ProducerId, Product, PID,
					Consumers, Products)
    end.

notifyConsumerAndKeepManaging(Consumers, Products) ->
    [PID] = Consumers,
    [MoreOldProduct] = Products,
    PID ! {MoreOldProduct},
    manage(lists:sublist(Consumers, 2, length(Consumers)),
	   lists:sublist(Products, 2, length(Products))).

receiveConsumerAndKeepManaging(ConsumerId, PID,
			       Consumers, Products) ->
    io:format("[buffer] receive consumer: ~p ~p ~n",
	      [ConsumerId, PID]),
    NextConsumers = Consumers ++ [PID],
    if length(Products) == 0 ->
	   manage(NextConsumers, Products);
       true ->
	   notifyConsumerAndKeepManaging(NextConsumers, Products)
    end.

receiveProductAndKeepManaging(ProducerId, Product, PID,
			      Consumers, Products) ->
    io:format("[buffer] receive producer: ~p ~p ~p ~n",
	      [ProducerId, Product, PID]),
    NextProducts = Products ++ [Product],
    if length(Consumers) == 0 ->
	   manage(Consumers, NextProducts);
       true ->
	   notifyConsumerAndKeepManaging(Consumers, NextProducts)
    end.
