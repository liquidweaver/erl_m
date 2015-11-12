-module(maybe_m).

-export([ maybe_monad/0,
          nothing/0,
          just/1,
          from_just/1,
          show_maybe/1,
          from_maybe/2
        ]).

-type maybe_m() :: nothing | {just, any()}.

-spec maybe_monad() -> monad:monad().
maybe_monad() ->
  monad:make_monad(either_m,
                   fun bind/2,
                   fun just/1).

-spec just(any()) -> maybe_m().
just(Value) -> {just, Value}.

-spec nothing() -> maybe_m().
nothing() -> nothing.

-spec from_just(maybe_m()) -> any().
from_just({just, V}) -> V.

-spec show_maybe(maybe_m()) -> string().
show_maybe(nothing) ->
  "Nothing";
show_maybe({just, Value}) ->
  io_lib:format("Just ~p", [Value]).

-spec from_maybe(any(), maybe_m()) -> any().
from_maybe(Default, nothing) -> Default;
from_maybe(_, {just, Value}) -> Value.

bind(nothing, _Fun) -> nothing;
bind({just, Value}, Fun) -> Fun(Value).
