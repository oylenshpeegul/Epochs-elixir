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

  We really want to write something like

  	NaiveDateTime.new(1969,12,31,0,0,0,0)
  	|> plus_days(days)
  	|> plus_months(months)
  	|> plus_seconds(seconds)

  but the functions we need are scattered about the :calendar module.
  """
  def google_calendar(n) do

  	{total_days, seconds} = div_rem(n, 24 * 60 * 60)

  	# A "Google month" has 32 days!
  	{months, days} = div_rem(total_days, 32)

	{:ok, date} = Date.new(1969,12,31)
	{:ok, time} = Time.new(0,0,0, {0,6})

	date = date
	|> Calendar.Date.add!(days)
	|> plus_months(months)
	
	Calendar.NaiveDateTime.from_date_and_time!(date, time)
	|> Calendar.NaiveDateTime.add!(seconds)
	
  end

  @doc """
  Return both the div and the rem of the given division.
  """
  def div_rem(n, d) do
  	{div(n, d), rem(n, d)}
  end

  @doc """
  Return the date n months from the given date.
  """
  def plus_months(date, 0) do
  	date
  end
  def plus_months(date, n) do
  	dim = Calendar.Date.number_of_days_in_month(date)
  	plus_months(Calendar.Date.add!(date, dim), n-1)
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
