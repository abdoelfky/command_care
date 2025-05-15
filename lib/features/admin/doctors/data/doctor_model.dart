class DoctorModel {
  final String id;
  final String name;
  final String phone;
  final String gender;
  final String encounterStatus;
  final String status;

  DoctorModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.gender,
    required this.encounterStatus,
    required this.status,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? 'other',
      encounterStatus: map['encounterStatus'] ?? 'Unknown',
      status: map['status'] ?? 'Active',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'gender': gender,
      'encounterStatus': encounterStatus,
      'status': status,
    };
  }
}
