# 1st arg: 12-hour time string with the format '[H]H:MM{AM|PM}'
# 2nd arg: (signed) integer --  number of minutes to add to the time of day represented by the first argument

# Return value: '[H]H:MM{AM|PM}'

# AddMinutes('9:13 AM', 200) --> '12:33 PM'

# INCLUDE TESTS

def add_minutes(time, minutes)
  military_time = convert_to_military_time(time)

  hour = military_time[0..-4].to_i
  mins = military_time[-2..-1].to_i

  meta = minutes.abs.divmod(60)

  if minutes.negative?
    hour -= meta.first
    mins -= meta.last
    mins += 60 if mins.negative?
  else
    hour += meta.first
    mins += meta.last
  end

  if hour > 24
    hour -= 24
  elsif hour.negative?
    hour += 24
  end

  new_time = "#{hour}:#{mins}"

  return convert_to_american_time(new_time)
end

def convert_to_military_time(time)
  minutes = time[-5..-4].to_i
  hour = time[0..-7].to_i
  am_or_pm = time[-2..-1]

  return time[0..-4] if am_or_pm == 'AM'

  hour += 12 if hour != 12

  return "#{hour}:#{minutes}"
end

def convert_to_american_time(time)
  minutes = time[-2..-1].to_i
  hour = time[0..-4].to_i
  am_or_pm = hour > 11 ? 'PM' : 'AM'

  hour -= 12 if hour > 12

  return "#{hour}:#{minutes} #{am_or_pm}"
end
