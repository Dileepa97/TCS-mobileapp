class DateToString {
  String stringDate(DateTime date) {
    return date.year.toString() +
        '-' +
        date.month.toString() +
        '-' +
        date.day.toString();
  }
}
