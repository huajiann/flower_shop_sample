import 'package:flower_shop_app/model/new_services_data_model.dart';
import 'package:flower_shop_app/navigation/selected_index_notifier.dart';
import 'package:flower_shop_app/pages/home/home_page.dart';
import 'package:flower_shop_app/pages/mall/mall_details_page.dart';
import 'package:flower_shop_app/widgets/item_card.dart';
import 'package:flutter/material.dart';

class HomeNewServicesList extends StatelessWidget {
  const HomeNewServicesList({super.key, required this.data});

  final List<NewServicesDataModel> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF4F4F4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          _buildHeader(),
          SizedBox(height: 16),
          _buildServiceList(context),
          SizedBox(height: 36),
          _buildShopSection(context),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New Services'.toUpperCase()),
              InkWell(
                onTap: () {
                  // Switch to Mall tab (index 1)
                  selectedIndexNotifier.value = 1;
                },
                child: Text(
                  'View All',
                  style: TextStyle(color: Color(0xFF707070), fontSize: 12),
                ),
              ),
            ],
          ),
          Text(
            'Recommended based on your preference',
            style: TextStyle(color: Color(0xFF707070), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          spacing: 14,
          children: data.map((service) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MallDetailsPage(service: service),
                  ),
                );
              },
              child: ItemCard(service: service),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildShopSection(BuildContext context) {
    return Stack(
      children: [
        _buildShopList(context),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          width: 160,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF4F4F4), Color(0xF3F4F4F4), Color(0x00F4F4F4)],
              stops: [0.0, 0.55, 1.0],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Image.asset(
            'assets/images/shop_plants_icon_main.png',
            width: 78,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildShopList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 14,
        children: [
          SizedBox(width: 60),
          ...PlantsType.values.map((service) {
            return InkWell(
              onTap: () {},
              child: Image.asset(
                service.shopPlantIconPath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            );
          }),
        ],
      ),
    );
  }
}
