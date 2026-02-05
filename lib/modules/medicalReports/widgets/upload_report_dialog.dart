import 'package:Clarminds/modules/medicalReports/widgets/reportNameDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/medical_reports_controller.dart';

class UploadReportDialog extends StatelessWidget {
  const UploadReportDialog({super.key});

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
              'Upload Medical Reports',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Text(
              'Upload Your Medical Reports, Lab Results, Prescriptions,\n'
                  'and Other Health Documents. Supported Formats: PDF,\n'
                  'JPG, PNG, DICOM',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 20),

            InkWell(
              onTap: () async {
                await controller.pickFile();
                if (controller.selectedFile != null) {
                  Get.back();
                  Get.dialog(const ReportNameDialog());
                }
              },
              child: Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.upload, size: 40),
                    SizedBox(height: 8),
                    Text('Drag & Drop Your Files Here'),
                    Text('Or Click The Button Below To Browse',
                        style: TextStyle(fontSize: 11)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await controller.pickFile();
                if (controller.selectedFile != null) {
                  Get.back();
                  Get.dialog(const ReportNameDialog());
                }
              },
              child: const Text('Browse Files'),
            )
          ],
        ),
      ),
    );
  }
}
