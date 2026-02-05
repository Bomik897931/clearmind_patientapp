import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../controller/medical_reports_controller.dart';
import '../widgets/report_card.dart';
import '../widgets/upload_report_dialog.dart';

class MedicalReportScreen extends StatelessWidget {
  final controller = Get.put(MedicalReportController());

  MedicalReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Medical Reports',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => Get.dialog(const UploadReportDialog()),
            icon: const Icon(Icons.upload, color: AppColors.primary),
            label: const Text(
              'Upload Report',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.reports.isEmpty) {
          return const Center(child: Text('No documents found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.reports.length,
          itemBuilder: (_, index) {
            final report = controller.reports[index];
            return ReportCard(
              report: report,
              onDelete: () {
                Get.defaultDialog(
                  title: 'Delete',
                  middleText: 'Are you sure you want to delete this document?',
                  onConfirm: () {
                    Get.back();
                    controller.deleteReport(report.documentId);
                  },
                  onCancel: () {},
                );
              },
            );
          },
        );
      }),
    );
  }
}
