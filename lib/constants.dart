final DateTime yesterday = DateTime(DateTime.now().year, DateTime.now().month,
    DateTime.now().day, DateTime.now().hour - 24);
final DateTime weekAgo =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 7);

final DateTime monthAgo =
    DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);

final DateTime threeMonthsAgo =
    DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);

final DateTime sixMonthsAgo =
    DateTime(DateTime.now().year, DateTime.now().month - 6, DateTime.now().day);

final DateTime yearAgo = DateTime(
    DateTime.now().year, DateTime.now().month, DateTime.now().day - 365);

final DateTime threeYearAgo = DateTime(
    DateTime.now().year, DateTime.now().month, DateTime.now().day - 1095);
