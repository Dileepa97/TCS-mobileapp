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
