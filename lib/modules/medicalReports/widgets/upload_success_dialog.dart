import 'package:flutter/material.dart';

class UploadSuccessDialog extends StatelessWidget {
  const UploadSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 10),
            Text('Report Successfully Uploaded'),
          ],
        ),
      ),
    );
  }
}
