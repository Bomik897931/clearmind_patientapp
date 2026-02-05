import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/medicalReportModel.dart';

class ReportCard extends StatelessWidget {
  final MedicalReport report;
  final VoidCallback onDelete;

  const ReportCard({
    super.key,
    required this.report,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 140,
              color: AppColors.grey100,
              child: const Center(
                child: Icon(Icons.picture_as_pdf, size: 40),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  report.fileName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.red),
                onPressed: onDelete,
              ),
            ],
          ),
          // const SizedBox(height: 6),
          Text(
            'Uploaded: ${report.formattedDate}',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.grey600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                report.fileSize,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.grey600,
                ),
              ),
              const SizedBox(width: 6),
              const Text('•'),
              const SizedBox(width: 6),
              Text(
                report.fileType,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.grey600,
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }
}
