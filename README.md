# Epochs-elixir
Convert various epoch times to [NaiveDateTime](http://elixir-lang.org/docs/stable/elixir/NaiveDateTime.html) times in [Elixir](http://elixir-lang.org/).

## Example

```
$ iex -S mix
Erlang/OTP 19 [erts-8.1] [source-77fb4f8] [64-bit] [smp:2:2] [async-threads:10] [hipe] [kernel-poll:false]

Compiling 1 file (.ex)
Generated epochs app
Interactive Elixir (1.3.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> Epochs.unix(1234567890)
~N[2009-02-13 23:31:30.000000]
iex(2)> Epochs.chrome(12879041490654321)
~N[2009-02-13 23:31:30.654319]
iex(3)> 
```

Now there are functions in the other direction!

```
iex(4)> Epochs.to_unix(~N[2009-02-13 23:31:30.000000])
1234567890
iex(5)> Epochs.to_chrome(~N[2009-02-13 23:31:30.654319])
12879041490654320
```

## Contributors

[@noppers](https://github.com/noppers) originally worked out how to do the Google Calendar calculation.

## See Also

This project was originally done in [Perl](https://github.com/oylenshpeegul/Epochs-perl).

There is also a version in [Go](https://github.com/oylenshpeegul/epochs).

See [the Epochs gh-page](http://oylenshpeegul.github.io/Epochs-perl/) for motivation.
