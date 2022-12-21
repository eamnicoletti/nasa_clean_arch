// ignore_for_file: file_names

class DateToStringConverter {
  static String convert(DateTime date) {
    var dateSplitted = date.toString().split(' ');
    return dateSplitted.first;
  }
}
