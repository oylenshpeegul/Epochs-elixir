# Epochs-elixir
Convert various epoch times to [NaiveDateTime](http://elixir-lang.org/docs/stable/elixir/NaiveDateTime.html) times in [Elixir](http://elixir-lang.org/).

## standardlibraryonly branch

This branch uses only the Date, Time, DateTime, and NaiveDateTime types in the standard library. Without using the external :calendar library, we are only able to implement chrome, cocoa, java, mozilla, symbian, unix, uuid\_v1, windows\_date, and windows_file. We are not able to implement icq, ole, or any of the to\_ functions except for to\_google\_calendar. Interestingly, we cannot implement google\_calendar.


