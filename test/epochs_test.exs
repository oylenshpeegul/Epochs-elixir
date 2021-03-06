defmodule EpochsTest do
  use ExUnit.Case, async: true
  doctest Epochs

  test "apfs 1_234_567_890_000_000_000" do
	assert Epochs.apfs(1_234_567_890_000_000_000) ==
	  ~N[2009-02-13 23:31:30.000000]
  end
  test "to_apfs ~N[2009-02-13 23:31:30.000000]" do
	assert Epochs.to_apfs(~N[2009-02-13 23:31:30.000000]) ==
	  1_234_567_890_000_000_000
  end
  
  test "chrome 12_879_041_490_000_000" do
	assert Epochs.chrome(12_879_041_490_000_000) ==
	  ~N[2009-02-13 23:31:30.000000]
  end
  test "to_chrome ~N[2009-02-13 23:31:30.000000]" do
	assert Epochs.to_chrome(~N[2009-02-13 23:31:30.000000]) ==
	  12_879_041_490_000_000
  end

  # Without big floats, we only get enough accuracy to test three
  # digits after the decimal place.
  test "chrome 12912187816559000" do
	assert Epochs.chrome(12912187816559000) ==
	  ~N[2010-03-04 14:50:16.559000]
  end
  test "to_chrome ~N[2010-03-04 14:50:16.559000]" do
	assert Epochs.to_chrome(~N[2010-03-04 14:50:16.559000]) ==
	  12912187816559000
  end

  test "cocoa 256_260_690" do
	assert Epochs.cocoa(256_260_690) ==
	  ~N[2009-02-13 23:31:30.000000]
  end
  test "to_cocoa ~N[2009-02-13 23:31:30.000000]" do
	assert Epochs.to_cocoa(~N[2009-02-13 23:31:30.000000]) ==
	  256_260_690
  end

  test "google_calendar 1_297_899_090" do
  	assert Epochs.google_calendar(1_297_899_090) ==
  	  ~N[2009-02-13 23:31:30.000000]
  end

  test "to_google_calendar ~N[2009-02-13 23:31:30.000000]" do
  	assert Epochs.to_google_calendar(~N[2009-02-13 23:31:30.000000]) ==
  	  1_297_899_090
  end

  test "icq 0" do
  	assert Epochs.icq(0) ==
  	  ~N[1899-12-30 00:00:00.000000]
  end

  test "icq 39857.980209" do
  	assert Epochs.icq(39857.980209) ==
  	  ~N[2009-02-13 23:31:30.000000]
  end

  test "to_icq ~N[2009-02-13 23:31:30.000000]" do
  	assert_in_delta Epochs.to_icq(~N[2009-02-13 23:31:30.000000]),
	  39857.980209, 0.000001
  end

  test "to_icq ~N[2012-05-27 07:07:17.999999]" do
  	assert_in_delta Epochs.to_icq(~N[2012-05-27 07:07:17.999999]),
  	  41056.296736, 0.000001
  end

  test "java 1_234_567_890_000" do
	assert Epochs.java(1_234_567_890_000) ==
	  ~N[2009-02-13 23:31:30.000000]
  end
  test "to_java ~N[2009-02-13 23:31:30.000000]" do
	assert Epochs.to_java(~N[2009-02-13 23:31:30.000000]) ==
	  1_234_567_890_000
  end

  test "mozilla 1_234_567_890_000_000" do
	assert Epochs.mozilla(1_234_567_890_000_000) ==
	  ~N[2009-02-13 23:31:30.000000]
  end
  test "to_mozilla ~N[2009-02-13 23:31:30.000000]" do
	assert Epochs.to_mozilla(~N[2009-02-13 23:31:30.000000]) ==
	  1_234_567_890_000_000
  end

  test "ole <<222, 221, 221, 93, 63, 118, 227, 64>>" do
	assert Epochs.ole(<<222, 221, 221, 93, 63, 118, 227, 64>>) ==
	  ~N[2009-02-13 23:31:30.000000]
  end

  test "to_ole ~N[2009-02-13 23:31:30.000000]" do
	assert Epochs.to_ole(~N[2009-02-13 23:31:30.000000]) ==
	  <<222, 221, 221, 93, 63, 118, 227, 64>>
  end
  
  test "symbian 63_401_787_090_000_000" do
	assert Epochs.symbian(63_401_787_090_000_000) ==
	  ~N[2009-02-13 23:31:30.000000]
  end
  test "to_symbian ~N[2009-02-13 23:31:30.000000]" do
	assert Epochs.to_symbian(~N[2009-02-13 23:31:30.000000]) ==
	  63_401_787_090_000_000
  end

  test "unix 1234567890" do
	assert Epochs.unix(1234567890) ==
	  ~N[2009-02-13 23:31:30.000000]
  end
  test "to_unix ~N[2009-02-13 23:31:30.000000]" do
	assert Epochs.to_unix(~N[2009-02-13 23:31:30.000000]) ==
	  1234567890
  end

  test "uuid_v1 134_538_606_900_000_000" do
	assert Epochs.uuid_v1(134_538_606_900_000_000) ==
	  ~N[2009-02-13 23:31:30.000000]
  end
  test "to_uuid_v1 ~N[2009-02-13 23:31:30.000000]" do
	assert Epochs.to_uuid_v1(~N[2009-02-13 23:31:30.000000]) ==
	  134_538_606_900_000_000
  end

  test "windows_date 633_701_646_900_000_000" do
	assert Epochs.windows_date(633_701_646_900_000_000) ==
	  ~N[2009-02-13 23:31:30.000000]
  end
  test "to_windows_date ~N[2009-02-13 23:31:30.000000]" do
	assert Epochs.to_windows_date(~N[2009-02-13 23:31:30.000000]) ==
	  633_701_646_900_000_000
  end

  test "windows_file 128_790_414_900_000_000" do
	assert Epochs.windows_file(128_790_414_900_000_000) ==
	  ~N[2009-02-13 23:31:30.000000]
  end
  test "to_windows_file ~N[2009-02-13 23:31:30.000000]" do
	assert Epochs.to_windows_file(~N[2009-02-13 23:31:30.000000]) ==
	  128_790_414_900_000_000
  end
  
end
