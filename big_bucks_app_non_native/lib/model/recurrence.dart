enum Recurrence {
  oneTime,
  daily,
  weeky,
  monthly;

  static Recurrence fromShortString(String recurrence) {
    switch (recurrence) {
      case 'o':
        return Recurrence.oneTime;

      case 'd':
        return Recurrence.daily;

      case 'w':
        return Recurrence.weeky;

      case 'm':
        return Recurrence.monthly;

      default:
        throw const FormatException("invalid recurrence format");
    }
  }

  String toShortString() {
    switch (this) {
      case Recurrence.oneTime:
        return 'o';

      case Recurrence.daily:
        return 'd';

      case Recurrence.weeky:
        return 'w';

      case Recurrence.monthly:
        return 'm';
    }
  }
}
