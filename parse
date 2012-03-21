#!/usr/bin/awk -f

BEGIN{
  FS = ":| +";
  formatspec = "%b %d %T";

  lastyear_cmd = "TZ=GMT date +%Y";
  if ((lastyear_cmd | getline result) > 0) {
    last_year = result-1;
  }
  close(lastyear_cmd);

  today_cmd = "TZ=GMT date +%s";
  if ((today_cmd | getline result) > 0) {
    today_ts = result;
  }
  close(today_cmd);
}
{
  # Logfile times are in Month Day Hour:Minute:Second format in the local
  # timezone. We manually adjust the timezone to GMT when we call date so we
  # get multiple of 86400 day timestamps.
  timespec = $1 " " $2 " " $3 ":" $4 ":" $5;
  
  # We need to figure out what year the date refers to. If the data timestamp is
  # greater than the current timestamp, we know it was from last year.
  timespec_cmd = "TZ=GMT date -jf '" formatspec "' '" timespec "' +%s";
  if ((timespec_cmd | getline result) > 0) {
    timespec_ts = result;
    if (timespec_ts > today_ts) {
      timespec_lastyear_cmd = "TZ=GMT date -jf '" formatspec " %Y' '" timespec " " last_year "' +%s";
      if ((timespec_lastyear_cmd | getline result) > 0) {
        timespec_ts = result;
      }
      close(timespec_lastyear_cmd);
    }
  }
  close(timespec_cmd);

  print timespec_ts;
}
