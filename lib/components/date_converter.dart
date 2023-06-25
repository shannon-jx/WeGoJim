class DateConverter {
  static int convert(DateTime date) {
    int day = date.day;
    int month = date.month;
    int year = date.year;
    int results = (day * 1000000) + (month * 10000) + year;
    return results;
  }

  static DateTime convertBack(int date) {
    int day = date ~/ 1000000;
    int month = (date ~/ 10000) % 100;
    int year = date % 10000;
    return DateTime(year, month, day);
  }
}