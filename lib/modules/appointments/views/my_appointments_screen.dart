import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
// ❌ REMOVE THIS IMPORT
// import '../../../widgets/bottom_nav_bar.dart';
import '../../../widgets/loading_widget.dart';
import '../controllers/my_appointments_controller.dart';
import '../widgets.dart/appointment_card.dart';
import '../widgets.dart/videos_dropdown_popup_dialog.dart';

class MyAppointmentsScreen extends GetView<MyAppointmentsController> {
  const MyAppointmentsScreen({super.key});

  static final _videosButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.w),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Appointment',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
              key: _videosButtonKey,
              onTap: () => _showVideosDropdown(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary, width: 1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.play_circle_outline,
                      size: 18.w,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Videos',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 18.w,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TabBar(
              controller: controller.tabController,
              isScrollable: true,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 2,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              labelPadding: EdgeInsets.only(right: 24.w),
              tabAlignment: TabAlignment.start,
              tabs: const [
                Tab(text: 'Upcoming'),
                Tab(text: 'Completed'),
                Tab(text: 'Cancelled'),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingWidget();
        }

        return Container(
          color: AppColors.grey50,
          child: TabBarView(
            controller: controller.tabController,
            children: [
              _buildAppointmentsList(
                controller.upcomingAppointments,
                'upcoming',
              ),
              _buildAppointmentsList(
                controller.completedAppointments,
                'completed',
              ),
              _buildAppointmentsList(
                controller.cancelledAppointments,
                'cancelled',
              ),
            ],
          ),
        );
      }),
      // ❌ REMOVED bottomNavigationBar
    );
  }

  void _showVideosDropdown(BuildContext context) {
    VideosDropdownPopup.show(
      context,
      buttonKey: _videosButtonKey,
      onNewOnlineConsultation: () {
        controller.onVideoSelected('New Online Consultation Vedio');
        print('Selected: New Online Consultation Vedio');
      },
      onWhyReally: () {
        controller.onVideoSelected('Why Really Happened');
        print('Selected: Why Really Happened');
      },
      onWhatIsAnxiety: () {
        controller.onVideoSelected('What is Anxiety?');
        print('Selected: What is Anxiety?');
      },
    );
  }

  Widget _buildAppointmentsList(List appointments, String type) {
    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 64.w,
              color: AppColors.textTertiary,
            ),
            SizedBox(height: 16.h),
            Text(
              'No appointments found',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return AppointmentCard(
          appointment: appointment,
          type: type,
          onTap: () => controller.onAppointmentTap(appointment),
          onReschedule: () => controller.onReschedule(appointment),
          onCancel: () => controller.showCancelDialog(appointment),
          onLeaveReview: () => controller.onLeaveReview(appointment),
          onBookAgain: () => controller.onBookAgain(appointment),
          onCall: () => controller.onCall(appointment),
        );
      },
    );
  }
}
