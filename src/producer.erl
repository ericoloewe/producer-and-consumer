-module(producer).

%% API exports
-export([start/3]).

start(ProducerId, BufferPid, TimeToProduce) ->
    io:format("[producer] #~p started ~n", [ProducerId]),
    produce(ProducerId, BufferPid, TimeToProduce).

produce(ProducerId, BufferPid, TimeToProduce) ->
    io:format("[producer] #~p working ~n", [ProducerId]),
    Product = TimeToProduce,
    timer:sleep(Product),
    BufferPid ! {ProducerId, Product, self()},
    produce(ProducerId, BufferPid, TimeToProduce).
