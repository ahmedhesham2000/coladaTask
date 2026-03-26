import 'package:coladatask/features/menu/domain/entities/venue.dart';
import 'package:coladatask/features/menu/presentation/widgets/branch_info.dart';
import 'package:coladatask/features/menu/presentation/widgets/pickup_badge.dart';
import 'package:coladatask/features/menu/presentation/widgets/venue_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VenueInfoCard extends StatelessWidget {
  const VenueInfoCard({super.key, required this.venue});
  final VenueEntity venue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffE7E5E4)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 12.h,
                bottom: 0.h,
              ),
              child: VenueHeader(venue: venue),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PickupBadge(),

                BranchInfo(venue: venue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
