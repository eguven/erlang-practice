-module(quicksort).
-export([qsort/1]).

%combine(L1,N,L2) -> 
%  if
%    L1 == [] , L2 == [] -> [N];
%    L1 == [] -> [N|L2];
%    L2 == [] -> lists:append(L1,[N]);
%    true -> lists:append([L1,[N],L2])
%  end.

% combiner function
% [X],X,[X] -> [X]
combine([],N,[]) -> [N];
combine([],N,L2) -> [N|L2];
combine(L1,N,[]) -> lists:append(L1,[N]);
combine(L1,N,L2) -> lists:append([L1,[N],L2]).

% quicksort with HEAD as pivot
% filter written insead of lists:partition
qsort([]) -> [];
qsort([H|T]) ->
  combine(qsort(lists:filter(fun(X) -> X =< H end, T)),
          H,
          qsort(lists:filter(fun(X) -> X > H end, T))).
    
