defmodule EpochsTest do
  use ExUnit.Case, async: true
  doctest Epochs

  test "chrome 12_879_041_490_000_000" do
	assert Epochs.chrome(12_879_041_490_000_000) ==
	  ~N[2009-02-13 23:31:30.000000]
  end

  # Without big floats, we only get enough accuracy to test three
  # digits after the decimal place.
  test "chrome 12912187816559000" do
	assert Epochs.chrome(12912187816559000) ==
	  ~N[2010-03-04 14:50:16.559000]
  end

  test "cocoa 256_260_690" do
	assert Epochs.cocoa(256_260_690) ==
	  ~N[2009-02-13 23:31:30.000000]
  end

  test "to_google_calendar ~N[2009-02-13 23:31:30.000000]" do
  	assert Epochs.to_google_calendar(~N[2009-02-13 23:31:30.000000]) ==
  	  1_297_899_090
  end

  test "java 1_234_567_890_000" do
	assert Epochs.java(1_234_567_890_000) ==
	  ~N[2009-02-13 23:31:30.000000]
  end

  test "mozilla 1_234_567_890_000_000" do
	assert Epochs.mozilla(1_234_567_890_000_000) ==
	  ~N[2009-02-13 23:31:30.000000]
  end

  test "symbian 63_401_787_090_000_000" do
	assert Epochs.symbian(63_401_787_090_000_000) ==
	  ~N[2009-02-13 23:31:30.000000]
  end

  test "unix 1234567890" do
	assert Epochs.unix(1234567890) ==
	  ~N[2009-02-13 23:31:30.000000]
  end

  test "uuid_v1 134_538_606_900_000_000" do
	assert Epochs.uuid_v1(134_538_606_900_000_000) ==
	  ~N[2009-02-13 23:31:30.000000]
  end

  test "windows_date 633_701_646_900_000_000" do
	assert Epochs.windows_date(633_701_646_900_000_000) ==
	  ~N[2009-02-13 23:31:30.000000]
  end

  test "windows_file 128_790_414_900_000_000" do
	assert Epochs.windows_file(128_790_414_900_000_000) ==
	  ~N[2009-02-13 23:31:30.000000]
  end
  
end
