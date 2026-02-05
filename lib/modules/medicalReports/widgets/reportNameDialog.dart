import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/medical_reports_controller.dart';
import 'upload_success_dialog.dart';

class ReportNameDialog extends StatelessWidget {
  const ReportNameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MedicalReportController>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Report Name',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.reportNameController,
              decoration: const InputDecoration(
                hintText: 'Eg : Depression Assessment Report',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await controller.uploadReport();
                Get.back();
                Get.dialog(const UploadSuccessDialog());
              },
              child: const Text('Save Report'),
            )
          ],
        ),
      ),
    );
  }
}
