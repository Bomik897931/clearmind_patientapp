import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/medicalReportModel.dart';
import '../../../data/repositories/medReport_repository.dart';
import '../../../data/services/StorageService.dart';
import 'package:file_picker/file_picker.dart';

class MedicalReportController extends GetxController {
  final MedicalReportRepository _repository =
  MedicalReportRepository();

  final RxList<MedicalReport> reports = <MedicalReport>[].obs;
  final RxBool isLoading = false.obs;
  File? selectedFile;
  String? selectedFileName;
  TextEditingController reportNameController = TextEditingController();

  // final int userId;
  //
  // MedicalReportController(this.userId);

  final StorageService _storage = StorageService();

  @override
  void onInit() {
    super.onInit();
    fetchReports();
  }

  Future<void> fetchReports() async {
    try {
      isLoading.value = true;
      final token = await _storage.getToken();
      final user = await _storage.getUser();
      final data = await _repository.getReports(userId: user?.userId,token: token!);
      reports.value = data;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadReport() async {
    try {
      final token = await _storage.getToken();
      if (token == null) {
        Get.snackbar('Error', 'Login required');
        return;
      }

      if (selectedFile == null) {
        Get.snackbar('Error', 'Please select a document');
        return;
      }

      if (reportNameController.text.trim().isEmpty) {
        Get.snackbar('Error', 'Please enter report name');
        return;
      }

      isLoading.value = true;

      final success = await _repository.uploadReport(
        token: token,
        file: selectedFile!,
        fileName: reportNameController.text.trim(),
        // reportName: reportNameController.text.trim(),
      );

      if (success) {
        await fetchReports();

        // reset state
        selectedFile = null;
        selectedFileName = null;
        reportNameController.clear();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> deleteReport(int documentId) async {
    try {
      isLoading.value = true;

      final token = await _storage.getToken();
      final success =
      await _repository.deleteReport(documentId: documentId,token: token!);

      if (success) {
        reports.removeWhere(
                (element) => element.documentId == documentId);
        Get.snackbar('Success', 'Document deleted');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      type: FileType.custom,
    );

    if (result != null) {
      selectedFile = File(result.files.single.path!);
      selectedFileName = result.files.single.name;
    }
  }

}
