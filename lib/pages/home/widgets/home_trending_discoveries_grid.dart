import 'package:flower_shop_app/model/new_services_data_model.dart';
import 'package:flower_shop_app/pages/mall/mall_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTrendingDiscoveriesGrid extends StatelessWidget {
  const HomeTrendingDiscoveriesGrid({super.key, required this.data});

  final List<NewServicesDataModel> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF112F22),
      child: Column(
        children: [
          Image.asset(
            'assets/images/trending_discoveries.jpg',
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16),
          _buildGrid(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return MasonryGridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: EdgeInsets.zero,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MallDetailsPage(service: data[index]),
              ),
            );
          },
          child: _buildGridItem(data[index]),
        );
      },
    );
  }

  Widget _buildGridItem(NewServicesDataModel service) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          if (service.imagePath != null)
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.asset(service.imagePath!, fit: BoxFit.cover),
            ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.tooltip ?? '',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  service.title ?? '',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
