defmodule Epochs do
  @moduledoc """
  The Epochs module converts various times to Unix time.
  """

  @seconds_per_day 24 * 60 * 60
  
  @doc """
  Chrome time is the number of microseconds since 1601-01-01, which is
  11,644,473,600 seconds before 1970-01-01.
  """
  def chrome(n) do
	epoch2time(n, 1_000_000, -11_644_473_600)
  end

  @doc """
  Cocoa time is the number of seconds since 2001-01-01, which is
  978,307,200 seconds after 1970-01-01.
  """
  def cocoa(n) do
	epoch2time(n, 1, 978_307_200)
  end

  @doc """
  Google Calendar time seems to count 32-day months from the day
  before the Unix epoch. @noppers worked out how to do this.
  """
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
  Java time is the number of milliseconds since 1970-01-01.
  """
  def java(n) do
	epoch2time(n, 1_000, 0)
  end

  @doc """
  Mozilla time is the number of microseconds since 1970-01-01.
  """
  def mozilla(n) do
	epoch2time(n, 1_000_000, 0)
  end

  @doc """
  Symbian time is the number of microseconds since the year 0, which
  is 62,167,219,200 seconds before 1970-01-01.
  """
  def symbian(n) do
	epoch2time(n, 1_000_000, -62_167_219_200)
  end

  @doc """
  Unix time is the number of seconds since 1970-01-01.
  """
  def unix(n) do
	epoch2time(n, 1, 0)
  end

  @doc """
  UUID version 1 time (RFC 4122) is the number of hectonanoseconds
  (100 ns) since 1582-10-15, which is 12,219,292,800 seconds before
  1970-01-01.
  """
  def uuid_v1(n) do
	epoch2time(n, 10_000_000, -12_219_292_800)
  end

  @doc """
  Windows date time (e.g., .NET) is the number of hectonanoseconds
  (100 ns) since 0001-01-01, which is 62,135,596,800 seconds before
  1970-01-01.
  """
  def windows_date(n) do
	epoch2time(n, 10_000_000, -62_135_596_800)
  end

  @doc """
  Windows file time (e.g., NTFS) is the number of hectonanoseconds
  (100 ns) since 1601-01-01, which is 11,644,473,600 seconds before
  1970-01-01.
  """
  def windows_file(n) do
	epoch2time(n, 10_000_000, -11_644_473_600)
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

end
