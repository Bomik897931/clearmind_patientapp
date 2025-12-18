// // lib/models/slot.dart
// class Slot {
//   final int slotId;
//   final int doctorId;
//   final String slotDate;
//   final String doctorName;
//   final String startTime;
//   final String endTime;
//   final bool isBooked;
//   final bool isCancel;
//
//   Slot({
//     required this.slotId,
//     required this.doctorId,
//     required this.slotDate,
//     required this.doctorName,
//     required this.startTime,
//     required this.endTime,
//     required this.isBooked,
//     required this.isCancel,
//   });
//
//   factory Slot.fromJson(Map<String, dynamic> json) {
//     return Slot(
//       slotId: json['slotId'],
//       doctorId: json['doctorId'],
//       slotDate: json['slotDate'],
//       doctorName: json['doctorName'],
//       startTime: json['startTime'],
//       endTime: json['endTime'],
//       isBooked: json['isBooked'],
//       isCancel: json['isCancel'],
//     );
//   }
// }
//
// // lib/models/paginated_response.dart
// class PaginatedResponse<T> {
//   final List<T> items;
//   final int totalCount;
//   final int pageNumber;
//   final int pageSize;
//   final int totalPages;
//   final bool hasPrevious;
//   final bool hasNext;
//
//   PaginatedResponse({
//     required this.items,
//     required this.totalCount,
//     required this.pageNumber,
//     required this.pageSize,
//     required this.totalPages,
//     required this.hasPrevious,
//     required this.hasNext,
//   });
//
//   factory PaginatedResponse.fromJson(
//       Map<String, dynamic> json,
//       T Function(Map<String, dynamic>) fromJsonT,
//       ) {
//     return PaginatedResponse(
//       items: (json['items'] as List)
//           .map((item) => fromJsonT(item as Map<String, dynamic>))
//           .toList(),
//       totalCount: json['totalCount'],
//       pageNumber: json['pageNumber'],
//       pageSize: json['pageSize'],
//       totalPages: json['totalPages'],
//       hasPrevious: json['hasPrevious'],
//       hasNext: json['hasNext'],
//     );
//   }
// }

// lib/models/slot.dart
class Slot {
  final int slotId;
  final int doctorId;
  final String slotDate;
  final String doctorName;
  final String startTime;
  final String endTime;
  final bool isBooked;
  final bool isCancel;

  Slot({
    required this.slotId,
    required this.doctorId,
    required this.slotDate,
    required this.doctorName,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
    required this.isCancel,
  });

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      slotId: json['slotId'],
      doctorId: json['doctorId'],
      slotDate: json['slotDate'],
      doctorName: json['doctorName'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      isBooked: json['isBooked'],
      isCancel: json['isCancel'],
    );
  }

  // Format time from "09:00:00" to "09:00 AM"
  String get formattedStartTime => _formatTime(startTime);
  String get formattedEndTime => _formatTime(endTime);

  String get displayTime => '$formattedStartTime - $formattedEndTime';

  String _formatTime(String time) {
    final parts = time.split(':');
    if (parts.isEmpty) return time;

    int hour = int.parse(parts[0]);
    final minute = parts[1];
    final period = hour >= 12 ? 'PM' : 'AM';

    if (hour > 12) hour -= 12;
    if (hour == 0) hour = 12;

    return '$hour:$minute $period';
  }

  bool get isAvailable => !isBooked && !isCancel;
}
// lib/models/paginated_response.dart
class PaginatedResponse<T> {
  final List<T> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final bool hasPrevious;
  final bool hasNext;

  PaginatedResponse({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.hasPrevious,
    required this.hasNext,
  });

  factory PaginatedResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    return PaginatedResponse(
      items: (json['items'] as List)
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'],
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      totalPages: json['totalPages'],
      hasPrevious: json['hasPrevious'],
      hasNext: json['hasNext'],
    );
  }
}