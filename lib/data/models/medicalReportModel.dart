class MedicalReport {
  final int documentId;
  final String documentUrl;
  final String fileName;
  final String fileSize; // bytes as string
  final String dateAndTime;

  MedicalReport({
    required this.documentId,
    required this.documentUrl,
    required this.fileName,
    required this.fileSize,
    required this.dateAndTime,
  });

  factory MedicalReport.fromJson(Map<String, dynamic> json) {
    return MedicalReport(
      documentId: json['documentId'] ?? 0,
      documentUrl: json['documentUrl'] ?? '',
      fileName: json['fileName'] ?? '',
      fileSize: json['fileSize']?.toString() ?? '0',
      dateAndTime: json['dateAndTime'] ?? '',
    );
  }

  /// 📄 File extension (PDF / JPG / PNG)
  String get fileType {
    return fileName.split('.').last.toUpperCase();
  }

  /// 🖼 Image check
  bool get isImage {
    final name = fileName.toLowerCase();
    return name.endsWith('.jpg') ||
        name.endsWith('.jpeg') ||
        name.endsWith('.png');
  }

  /// 📦 Human readable file size
  String get formattedSize {
    final bytes = int.tryParse(fileSize) ?? 0;

    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }

  /// 🕒 Date for UI
  String get formattedDate {
    try {
      final dt = DateTime.parse(dateAndTime);
      return '${_month(dt.month)}/${dt.day}/${dt.year}, '
          '${dt.hour > 12 ? dt.hour - 12 : dt.hour}:${dt.minute.toString().padLeft(2, '0')} '
          '${dt.hour >= 12 ? 'PM' : 'AM'}';
    } catch (_) {
      return dateAndTime;
    }
  }

  static String _month(int m) {
    const months = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    return months[m - 1];
  }
}
