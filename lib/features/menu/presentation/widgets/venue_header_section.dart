import 'package:coladatask/core/shimmers/venie_header_shimmer.dart';
import 'package:coladatask/core/state/base_state.dart';
import 'package:coladatask/features/menu/domain/entities/venue.dart';
import 'package:coladatask/features/menu/presentation/widgets/cover_section.dart';
import 'package:coladatask/features/menu/presentation/widgets/venue_info_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VenueHeaderSection extends StatelessWidget {
  const VenueHeaderSection({super.key, required this.venueState});

  final BaseState<VenueEntity> venueState;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (venueState.requestState == RequestState.loading ||
            venueState.requestState == RequestState.initial)
          const VenueHeaderShimmer()
        else if (venueState.requestState == RequestState.error)
          Container(
            height: 200.h,
            color: Colors.grey.shade300,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, size: 40.sp, color: Colors.grey),
                  SizedBox(height: 8.h),
                  Text(
                    venueState.errorMessage ?? 'failed_to_load_venue'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          )
        else
          CoverSection(venue: venueState.data!),
        Padding(
          padding: EdgeInsets.only(top: 150.h),
          child: venueState.requestState == RequestState.success
              ? VenueInfoCard(venue: venueState.data!)
              : Container(
                  height: 100.h,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
        ),
      ],
    );
  }
}
