defmodule Epochs do
  @moduledoc """
  The Epochs module converts various times to Unix time.
  """

  @doc """
  Chrome time is the number of microseconds since 1601-01-01, which is
  11,644,473,600 seconds before 1970-01-01.
  """
  def chrome(n) do
	_epoch2time(n, 1_000_000, -11_644_473_600)
  end

  @doc """
  Cocoa time is the number of seconds since 2001-01-01, which is
  978,307,200 seconds after 1970-01-01.
  """
  def cocoa(n) do
	_epoch2time(n, 1, 978_307_200)
  end

  @doc """
  Google Calendar time seems to count 32-day months from the day
  before the Unix epoch. @noppers worked out how to do this.
  """
  def google_calendar(n) do

  	{whole_days, seconds} = div_rem(n, 24 * 60 * 60)

  	# A "Google month" has 32 days!
  	{months, days} = div_rem(whole_days, 32)

  	# A "Google epoch" is one day early.
  	{:ok, datetime} = NaiveDateTime.new(1969,12,31,0,0,0,0)
	
	datetime
  	|> plus_days(days)
  	|> plus_months(months)
	|> plus_seconds(seconds)

  end

  @doc """
  Return both the div and the rem of the given division.
  """
  def div_rem(n, d) do
  	{div(n, d), rem(n, d)}
  end

  @doc """
  Return the NaiveDateTime n days from the given NaiveDateTime.
  """
  def plus_days(ndt, n) do
  	d = NaiveDateTime.to_date(ndt) 
  	t = NaiveDateTime.to_time(ndt) 
	{:ok, ndt} = NaiveDateTime.new(Calendar.Date.add!(d, n), t)
	ndt
  end

  @doc """
  Return the NaiveDateTime n months from the given NaiveDateTime.
  """
  def plus_months(ndt, 0) do
  	ndt
  end
  def plus_months(ndt, n) do
  	d = NaiveDateTime.to_date(ndt)
  	dim = Calendar.Date.number_of_days_in_month(d)
  	plus_months(plus_days(ndt, dim), n-1)
  end

  @doc """
  Return the NaiveDateTime n seconds from the given NaiveDateTime.
  """
  def plus_seconds(ndt, n) do
  	Calendar.NaiveDateTime.add!(ndt, n)
  end

  @doc """
  Java time is the number of milliseconds since 1970-01-01.
  """
  def java(n) do
	_epoch2time(n, 1_000, 0)
  end

  @doc """
  Mozilla time is the number of microseconds since 1970-01-01.
  """
  def mozilla(n) do
	_epoch2time(n, 1_000_000, 0)
  end

  @doc """
  Symbian time is the number of microseconds since the year 0, which
  is 62,167,219,200 seconds before 1970-01-01.
  """
  def symbian(n) do
	_epoch2time(n, 1_000_000, -62_167_219_200)
  end

  @doc """
  Unix time is the number of seconds since 1970-01-01.
  """
  def unix(n) do
	_epoch2time(n, 1, 0)
  end

  @doc """
  UUID version 1 time (RFC 4122) is the number of hectonanoseconds
  (100 ns) since 1582-10-15, which is 12,219,292,800 seconds before
  1970-01-01.
  """
  def uuid_v1(n) do
	_epoch2time(n, 10_000_000, -12_219_292_800)
  end

  @doc """
  Windows date time (e.g., .NET) is the number of hectonanoseconds
  (100 ns) since 0001-01-01, which is 62,135,596,800 seconds before
  1970-01-01.
  """
  def windows_date(n) do
	_epoch2time(n, 10_000_000, -62_135_596_800)
  end

  @doc """
  Windows file time (e.g., NTFS) is the number of hectonanoseconds
  (100 ns) since 1601-01-01, which is 11,644,473,600 seconds before
  1970-01-01.
  """
  def windows_file(n) do
	_epoch2time(n, 10_000_000, -11_644_473_600)
  end

  def _epoch2time(n, q, s) do
	(div(n, q) + s) * 1_000_000
	|> DateTime.from_unix!(:microseconds)
	|> DateTime.to_naive
  end

end
