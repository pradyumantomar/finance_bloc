//convert dateTime object into String yyyymmdd

String convertDateTimeToString(DateTime dateTime) {
  //year
  String year = dateTime.year.toString();

  //month
  String month = dateTime.month.toString();
  month = addleadingZero(month);

  //day
  String day = dateTime.day.toString();
  day = addleadingZero(day);

  String yyyymmdd = year + month + day;
  return yyyymmdd;
}

String addleadingZero(String value) {
  if (value.length == 1) return '0$value';
  return value;
}
