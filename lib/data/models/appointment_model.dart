// lib/models/appointment.dart
class Appointment {
  final int appointmentId;
  final String doctorName;
  final String patientName;
  final String gender;
  final String appointmentDate;
  final String time;
  final String status;
  final String city;
  final String diagnosis;
  final String? previousAppointment;
  final String reason;
  final String notes;
  List<int>? slotId;
  // final int? slotsId;
  final int? userId;
  final int? doctorUserId;
  final int? patientUserId;
  final int? slotsDuration;
  final double? slotsFees;
  final String? phoneNumber;

  Appointment({
    required this.appointmentId,
    required this.doctorName,
    required this.patientName,
    required this.gender,
    required this.appointmentDate,
    required this.time,
    required this.status,
    required this.city,
    required this.diagnosis,
    this.previousAppointment,
    required this.reason,
    required this.notes,
    this.slotId,
    this.userId,
    this.doctorUserId,
    this.patientUserId,
    this.slotsDuration,
    this.slotsFees,
    this.phoneNumber,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appointmentId: json['appointmentId'],
      doctorName: json['doctorName'],
      patientName: json['patientName'],
      gender: json['gender'],
      appointmentDate: json['appointmentDate'],
      time: json['time'],
      status: _parseStatus(json['status']),
      city: json['city'],
      diagnosis: json['diagnosis'],
      previousAppointment: json['previousAppointment'],
      reason: json['reason'],
      notes: json['notes'],
      slotId: (json['slotsId'] as List?)?.map((e) => e as int).toList(),
      // slotId: json['slotsId'],
      userId: json['userId'],
      doctorUserId: json['doctorUserId'],
      patientUserId: json['patientUserId'],
      slotsDuration: json['slotsDuration'],
      slotsFees: parseDouble(json['slotsFees']),
      phoneNumber: json['phoneNumber'],
    );
  }
  /// Converts int/string/null → readable string
  static String _parseStatus(dynamic value) {
    if (value is int) {
      switch (value) {
        case 0:
          return 'Pending';
        case 1:
          return 'Confirmed';
        case 2:
          return 'Cancelled';
        default:
          return 'Unknown';
      }
    }
    if (value is String) return value;
    return 'Unknown';
  }

  static double? parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

}
