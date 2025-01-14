class Appointment {
  final String id;
  final String doctorName;
  final String specialization;
  final String date;
  final String time;
  final String status;
  final String image;

  Appointment({
    required this.id,
    required this.doctorName,
    required this.specialization,
    required this.date,
    required this.time,
    required this.status,
    required this.image,
  });

  // Getter to compute initials from doctor's name
  String get initials {
    List<String> names = doctorName.split(' ');
    String result = '';
    if (names.isNotEmpty) {
      result = names.first[0]; // First letter of the first name
      if (names.length > 1) {
        result += names.last[0]; // First letter of the last name
      }
    }
    return result.toUpperCase();
  }

}
