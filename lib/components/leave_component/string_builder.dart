class Convert {
  DateTime date;
  Convert({this.date});
  String stringDate() {
    return date.year.toString() +
        ' - ' +
        date.month.toString() +
        ' - ' +
        date.day.toString();
  }
}

class DateToString {
  static String stringDate(DateTime date) {
    return date.year.toString() +
        '-' +
        date.month.toString() +
        '-' +
        date.day.toString();
  }
}
