import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../controller/review_controller.dart';

class ReviewScreen extends GetView<ReviewController> {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: controller.cancel,
        ),
        title: const Text(
          'Write a Review',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Doctor Image
            Obx(() {
              final doc = controller.doctor.value;
              if (doc == null) return const SizedBox();

              return Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:  AppColors.circularprogressindicator.withOpacity(0.1),
                      image: doc.imageUrl.isNotEmpty &&
                          doc.imageUrl != 'image url' &&
                          doc.imageUrl != 'string'
                          ? DecorationImage(
                        image: NetworkImage(doc.imageUrl),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: doc.imageUrl.isEmpty ||
                        doc.imageUrl == 'image url' ||
                        doc.imageUrl == 'string'
                        ? Center(
                      child: Text(
                        doc.fullName.isNotEmpty
                            ? doc.fullName[0].toUpperCase()
                            : 'D',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: AppColors.circularprogressindicator,
                        ),
                      ),
                    )
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'How was your experience\nwith ${doc.fullName}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black87,
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 24),

            // Star Rating
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () => controller.setRating((index + 1).toDouble()),
                  icon: Icon(
                    index < controller.rating.value
                        ? Icons.star
                        : Icons.star_border,
                    size: 40,
                    color: index < controller.rating.value
                        ? AppColors.orange
                        : Colors.grey[300],
                  ),
                );
              }),
            )),

            const SizedBox(height: 32),

            // Review Text Field
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Write Your Review',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black87,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: controller.reviewTextController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Your review here....',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Recommendation Question
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Would you recommend ${controller.doctor.value?.fullName ?? 'this doctor'} to\nyour friends?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black87,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.setRecommendation(true),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: controller.wouldRecommend.value
                                  ?  AppColors.circularprogressindicator
                                  : Colors.grey[400]!,
                              width: 2,
                            ),
                          ),
                          child: controller.wouldRecommend.value
                              ? Center(
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.circularprogressindicator,
                              ),
                            ),
                          )
                              : null,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.setRecommendation(false),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: !controller.wouldRecommend.value
                                  ?  AppColors.circularprogressindicator
                                  : Colors.grey[400]!,
                              width: 2,
                            ),
                          ),
                          child: !controller.wouldRecommend.value
                              ? Center(
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.circularprogressindicator,
                              ),
                            ),
                          )
                              : null,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'No',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),

            const SizedBox(height: 48),

            // Action Buttons
            Obx(() => Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.isSubmitting.value
                        ? null
                        : controller.cancel,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(
                        color:  AppColors.circularprogressindicator.withOpacity(0.3),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color:  AppColors.circularprogressindicator,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.isSubmitting.value
                        ? null
                        : controller.submitReview,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor:  AppColors.circularprogressindicator,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: controller.isSubmitting.value
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
