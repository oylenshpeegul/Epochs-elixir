defmodule Epochs do
  @moduledoc """
  The Epochs module converts various times to Unix time.
  """

  @seconds_per_day 24 * 60 * 60

  @doc """
  APFS time is the number of nanoseconds since 1970-01-01.
  Cf., APFS filesystem format (https://blog.cugu.eu/post/apfs/).
  """
  def apfs(n) do
	epoch2time(n, 1_000_000_000, 0)
  end
  def to_apfs(ndt) do
	time2epoch(ndt, 1_000_000_000, 0)
  end
  
  @doc """
  Chrome time is the number of microseconds since 1601-01-01, which is
  11,644,473,600 seconds before 1970-01-01.
  """
  def chrome(n) do
	epoch2time(n, 1_000_000, -11_644_473_600)
  end
  def to_chrome(ndt) do
	time2epoch(ndt, 1_000_000, -11_644_473_600)
  end

  @doc """
  Cocoa time is the number of seconds since 2001-01-01, which is
  978,307,200 seconds after 1970-01-01.
  """
  def cocoa(n) do
	epoch2time(n, 1, 978_307_200)
  end
  def to_cocoa(ndt) do
	time2epoch(ndt, 1, 978_307_200)
  end

  @doc """
  Google Calendar time seems to count 32-day months from the day
  before the Unix epoch. @noppers worked out how to do this.
  """
  def google_calendar(n) do

  	{whole_days, seconds} = div_rem(n, @seconds_per_day)
  	{months, days} = div_rem(whole_days, 32)
	{:ok, date} = Date.new(1969,12,31)
	{:ok, time} = Time.new(0,0,0, {0,6})

	date = date
	|> Calendar.Date.add!(days)
	|> plus_months(months)
	
	Calendar.NaiveDateTime.from_date_and_time!(date, time)
	|> Calendar.NaiveDateTime.add!(seconds)
	
  end
  def to_google_calendar(ndt) do
	date = NaiveDateTime.to_date(ndt)
	time = NaiveDateTime.to_time(ndt)
	(((((date.year - 1970)*12 +
	    (date.month -  1))*32 +
	     date.day        )*24 +
	     time.hour       )*60 +
	     time.minute     )*60 +
	     time.second
  end

  @doc """
  ICQ time is the number of days since 1899-12-30. Days can have
  a fractional part.
  """
  def icq(days) do
	{:ok, date} = Date.new(1899,12,30)
	{:ok, time} = Time.new(0,0,0, {0,6})

	# Separate the integer part of the day and the fractional part of
	# the day. Want the fractional part of the day in seconds.
	intdays = trunc(days)
	seconds = trunc((days - intdays) * @seconds_per_day)

	{:ok, date} = Calendar.Date.add(date, intdays)
	
	Calendar.NaiveDateTime.from_date_and_time!(date, time)
	|> Calendar.NaiveDateTime.add!(seconds)
  end
  def to_icq(ndt) do
	dt1 = Calendar.NaiveDateTime.to_date_time_utc(ndt)

	{:ok, date} = Date.new(1899,12,30)
	{:ok, time} = Time.new(0,0,0, {0,6})
	{:ok, ndt2} = Calendar.NaiveDateTime.from_date_and_time(date, time)
	dt2 = Calendar.NaiveDateTime.to_date_time_utc(ndt2)

	{:ok, s, micros, _ba} = Calendar.DateTime.diff(dt1, dt2)
	
	(s + micros / 1_000_000) / @seconds_per_day
  end
  
  @doc """
  Java time is the number of milliseconds since 1970-01-01.
  """
  def java(n) do
	epoch2time(n, 1_000, 0)
  end
  def to_java(ndt) do
	time2epoch(ndt, 1_000, 0)
  end

  @doc """
  Mozilla time is the number of microseconds since 1970-01-01.
  """
  def mozilla(n) do
	epoch2time(n, 1_000_000, 0)
  end
  def to_mozilla(ndt) do
	time2epoch(ndt, 1_000_000, 0)
  end

  @doc """
  OLE time is the number of days since 1899-12-30. Days can have a
  fractional part and is given as a binary representing an IEEE 8-byte
  floating-point number.
  """
  def ole(days) do
	<<d_days::float-native>> = days
	icq d_days
  end
  def to_ole(binary) do
	d_days = to_icq(binary)
	<<d_days::float-native>>
  end
  
  @doc """
  Symbian time is the number of microseconds since the year 0, which
  is 62,167,219,200 seconds before 1970-01-01.
  """
  def symbian(n) do
	epoch2time(n, 1_000_000, -62_167_219_200)
  end
  def to_symbian(ndt) do
	time2epoch(ndt, 1_000_000, -62_167_219_200)
  end

  @doc """
  Unix time is the number of seconds since 1970-01-01.
  """
  def unix(n) do
	epoch2time(n, 1, 0)
  end
  def to_unix(ndt) do
	time2epoch(ndt, 1, 0)
  end

  @doc """
  UUID version 1 time (RFC 4122) is the number of hectonanoseconds
  (100 ns) since 1582-10-15, which is 12,219,292,800 seconds before
  1970-01-01.
  """
  def uuid_v1(n) do
	epoch2time(n, 10_000_000, -12_219_292_800)
  end
  def to_uuid_v1(ndt) do
	time2epoch(ndt, 10_000_000, -12_219_292_800)
  end

  @doc """
  Windows date time (e.g., .NET) is the number of hectonanoseconds
  (100 ns) since 0001-01-01, which is 62,135,596,800 seconds before
  1970-01-01.
  """
  def windows_date(n) do
	epoch2time(n, 10_000_000, -62_135_596_800)
  end
  def to_windows_date(ndt) do
	time2epoch(ndt, 10_000_000, -62_135_596_800)
  end

  @doc """
  Windows file time (e.g., NTFS) is the number of hectonanoseconds
  (100 ns) since 1601-01-01, which is 11,644,473,600 seconds before
  1970-01-01.
  """
  def windows_file(n) do
	epoch2time(n, 10_000_000, -11_644_473_600)
  end
  def to_windows_file(ndt) do
	time2epoch(ndt, 10_000_000, -11_644_473_600)
  end

  # Return both the div and the rem of the given division.
  defp div_rem(n, d) do
  	{div(n, d), rem(n, d)}
  end

  # Given a number n, a dividend d, and a shift s
  #   - do the divide and shift
  #   - interpret the result as a Unix time
  #   - return that time as a NaiveDateTime
  defp epoch2time(n, d, s) do
	trunc(((n / d) + s) * 1_000_000)
	|> DateTime.from_unix!(:microseconds)
	|> DateTime.to_naive
  end

  # Given a NaiveDateTime ndt, a multiplier m, and a shift s
  #   - convert that time to a NaiveDateTime
  #   - interpret the result as a Unix time
  #   - do the multiply and shift
  defp time2epoch(ndt, m, s) do
	micros = ndt
	|> Calendar.NaiveDateTime.to_date_time_utc
	|> DateTime.to_unix(:microseconds)
	
	trunc(m*((micros / 1_000_000) - s))
  end
  
  # Return the date n months from the given date.
  defp plus_months(date, 0) do
  	date
  end
  defp plus_months(date, n) when n > 0 do
  	dim = Calendar.Date.number_of_days_in_month(date)
  	plus_months(Calendar.Date.add!(date, dim), n-1)
  end

end
