-module(atm).
-export([account/1,account_test/0]).

% ATM machine, attempt at functions that carry state
%  account(N) -> Fun
%  (account(N)) ([Action, Input]) -> Fun

helper(Action, Balance, Amount) when Action==withdraw, Amount =< Balance -> 
  % can withdraw
  io:format("Withdrawing ~p.~n", [Amount]),
  account(Balance-Amount);

helper(Action, Balance, Amount) when Action==withdraw ->
  % can not withdraw
  io:format("Could not complete withdrawal (~p)! Balance: ~p.~n", [Amount, Balance]),
  account(Balance);

helper(Action, Balance, Amount) when Action==deposit ->
  % deposit
  io:format("Depositing ~p.~n", [Amount]),
  account(Balance+Amount);

helper(_, Balance, _) ->
  % unrecognized action
  io:format("Recognized operations: ~p ~p ~p~n",
    [[balance],[depostit, amount],[withdraw, amount]]),
    account(Balance).

helper(Action, Balance) when Action==balance ->
  % balance query
  io:format("Balance: ~p.~n", [Balance]),
  account(Balance);

helper(_, Balance) ->
  % unrecognized action
  io:format("Recognized operations: ~p ~p ~p~n",
    [[balance],[depostit, amount],[withdraw, amount]]),
    account(Balance).

account(Amount) ->
  fun(Args) -> case length(Args) of
                 2 -> [NewAction,Input] = Args, helper(NewAction, Amount, Input);
                 1 -> helper(hd(Args),Amount);
                 _ -> io:format("Recognized operations: ~p ~p ~p~n",
                                        [[balance],[deposit, amount],[withdraw, amount]])
               end
  end.

account_test() -> 
  ((((((atm:account(25))([balance])) ([deposit,5])) ([balance])) ([withdraw, 7.5])) ([balance])) ([withdraw,25]).
