class Patient {
  final String id;
  final String name;
  final String phone;
  // final String gender;
  // final String encounterStatus;
  final bool status;

  Patient({
    required this.id,
    required this.name,
    required this.phone,
    // required this.gender,
    // required this.encounterStatus,
    required this.status,
  });

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      // gender: map['gender'],
      // encounterStatus: map['encounterStatus'],
      status: map['status']??true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      // 'gender': gender,
      // 'encounterStatus': encounterStatus,
      'status': status,
    };
  }
}
