import 'package:flower_shop_app/model/appointment_data_model.dart';
import 'package:flower_shop_app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.model});

  final AppointmentDataModel model;
  AppointmentDataModel get _appointmentData => model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF244B3A)),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12),
            Text(
              'LOGO',
              style: GoogleFonts.roboto(
                fontSize: 44,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.white54,
                    thickness: 1,
                    endIndent: 8,
                  ),
                ),
                Text(
                  'NEXT APPOINTMENT',
                  style: GoogleFonts.roboto(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.white54,
                    thickness: 1,
                    indent: 8,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            _buildActions(),
            SizedBox(height: 16),
            _buildCreditSection(),
            SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: _buildActionItem(
              iconPath: 'assets/images/icon_calender.png',
              DateFormat(
                'dd MMM yyyy',
              ).format(_appointmentData.appointmentDate!),
            ),
          ),
          Expanded(
            flex: 7,
            child: _buildActionItem(
              iconPath: 'assets/images/icon_clock.png',
              DateFormat('HH:mm a').format(_appointmentData.appointmentDate!),
            ),
          ),
          Expanded(
            flex: 10,
            child: _buildActionItem(
              _appointmentData.location ?? 'No Location',
              iconPath: 'assets/images/icon_location.png',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(
    String label, {
    String? iconPath,
    VoidCallback? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          if (iconPath != null) ...[
            Image.asset(iconPath, width: 12, height: 12),
            SizedBox(width: 4),
          ],
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (onPressed != null)
            Image.asset(
              'assets/images/icon_arrow_1.png',
              width: 24,
              height: 24,
            ),
        ],
      ),
    );
  }

  Widget _buildCreditSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(27),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCreditItem(CreditItem.credit, value: 'RM100.00'),
            VerticalDivider(thickness: 1, color: Colors.grey, width: 20),
            _buildCreditItem(CreditItem.points, value: '200'),
            VerticalDivider(thickness: 1, color: Colors.grey, width: 20),
            _buildCreditItem(CreditItem.package, value: '1'),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditItem(CreditItem item, {required String value}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            item.name.toUpperCase(),
            style: TextStyle(color: Color(0xFF244B3A), fontSize: 10),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Color(0xFF244B3A),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
