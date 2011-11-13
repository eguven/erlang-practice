-module(factorials).
-export([fac/1,fact/2]).

% recursive factorial
fac(0) -> 1;
fac(N) -> N * fac(N-1).

% tail-recursive factorial
fact(1,Acc) -> Acc;
fact(N,Acc) -> fact(N-1,N*Acc).
