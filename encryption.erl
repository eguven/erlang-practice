-module(encryption).
-export([caesar_encrypt/2,caesar_decrypt/2]).

% caesar cipher, alphabet limits ignored though, cba :)

caesar_str_encrypt(In,Shift) -> 
  [Out+Shift || Out <- In].

caesar_str_decrypt(In,Shift) ->
  [Out-Shift || Out <- In].

caesar_binary_encrypt(<<In/binary>>,Shift) ->
  << <<((Out+Shift+256) rem 256)>> || <<Out>> <= In>>.

caesar_binary_decrypt(<<In/binary>>,Shift) ->
  << <<((Out-Shift+256) rem 256)>> || <<Out>> <= In>>.

% exported functions
% caesar_encrypt("abc",1) -> "bcd"
% caesar_encrypt(<<"abc">>,1) -> <<"bcd">>

caesar_encrypt(<<In/binary>>,Shift) ->
  caesar_binary_encrypt(In,Shift);
caesar_encrypt(In,Shift) ->
  caesar_str_encrypt(In,Shift).

caesar_decrypt(<<In/binary>>,Shift) ->
  caesar_binary_decrypt(In,Shift);
caesar_decrypt(In,Shift) ->
  caesar_str_decrypt(In,Shift).
