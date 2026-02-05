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
  final int slotId;  // ✅ Changed from List<int>? to int
  final int doctorId;
  final String slotDate;
  final String doctorName;
  final String startTime;
  final String endTime;
  final int slotDuration;  // ✅ Added
  final double doctorFee;  // ✅ Added
  final double platformFee;  // ✅ Added
  final double totalFee;  // ✅ Added
  final bool isBooked;
  final bool isCancel;

  Slot({
    required this.slotId,  // ✅ Changed
    required this.doctorId,
    required this.slotDate,
    required this.doctorName,
    required this.startTime,
    required this.endTime,
    required this.slotDuration,  // ✅ Added
    required this.doctorFee,  // ✅ Added
    required this.platformFee,  // ✅ Added
    required this.totalFee,  // ✅ Added
    required this.isBooked,
    required this.isCancel,
  });

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      slotId: json['slotId'] as int? ?? 0,  // ✅ Fixed
      doctorId: json['doctorId'] as int? ?? 0,
      slotDate: json['slotDate'] as String? ?? '',
      doctorName: json['doctorName'] as String? ?? '',
      startTime: json['startTime'] as String? ?? '',
      endTime: json['endTime'] as String? ?? '',
      slotDuration: json['slotDuration'] as int? ?? 0,  // ✅ Added
      doctorFee: (json['doctorFee'] as num?)?.toDouble() ?? 0.0,  // ✅ Added
      platformFee: (json['platformFee'] as num?)?.toDouble() ?? 0.0,  // ✅ Added
      totalFee: (json['totalFee'] as num?)?.toDouble() ?? 0.0,  // ✅ Added
      isBooked: json['isBooked'] as bool? ?? false,
      isCancel: json['isCancel'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slotId': slotId,
      'doctorId': doctorId,
      'slotDate': slotDate,
      'doctorName': doctorName,
      'startTime': startTime,
      'endTime': endTime,
      'slotDuration': slotDuration,
      'doctorFee': doctorFee,
      'platformFee': platformFee,
      'totalFee': totalFee,
      'isBooked': isBooked,
      'isCancel': isCancel,
    };
  }

  // Format time from "19:00:00" to "7:00 PM"
  String get formattedStartTime => _formatTime(startTime);
  String get formattedEndTime => _formatTime(endTime);
  String get displayTime => '$formattedStartTime - $formattedEndTime';

  String _formatTime(String time) {
    try {
      final parts = time.split(':');
      if (parts.length < 2) return time;

      int hour = int.tryParse(parts[0]) ?? 0;
      final minute = parts[1];
      final period = hour >= 12 ? 'PM' : 'AM';

      if (hour > 12) {
        hour -= 12;
      } else if (hour == 0) {
        hour = 12;
      }

      return '$hour:$minute $period';
    } catch (e) {
      return time;
    }
  }

  bool get isAvailable => !isBooked && !isCancel;

  // Format date
  String get formattedDate {
    try {
      final dateTime = DateTime.parse(slotDate);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return slotDate;
    }
  }

  @override
  String toString() {
    return 'Slot(id: $slotId, time: $displayTime, available: $isAvailable)';
  }
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
