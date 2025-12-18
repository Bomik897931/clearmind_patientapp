// lib/models/book_appointment_request.dart
class BookAppointmentRequest {
  final int doctorUserId;
  final int patientUserId;
  final int slotId;
  final String reason;
  final String notes;

  BookAppointmentRequest({
    required this.doctorUserId,
    required this.patientUserId,
    required this.slotId,
    required this.reason,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'doctorUserId': doctorUserId,
      'patientUserId': patientUserId,
      'slotId': slotId,
      'reason': reason,
      'notes': notes,
    };
  }
}