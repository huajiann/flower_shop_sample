import 'package:flower_shop_app/model/appointment_data_model.dart';
import 'package:flower_shop_app/model/location_data_model.dart';
import 'package:flower_shop_app/model/new_services_data_model.dart';
import 'package:flower_shop_app/pages/home/widgets/home_footer.dart';
import 'package:flower_shop_app/pages/home/widgets/home_header.dart';
import 'package:flower_shop_app/pages/home/widgets/home_new_services_list.dart';
import 'package:flower_shop_app/pages/home/widgets/home_trending_discoveries_grid.dart';
import 'package:flower_shop_app/pages/home/selection/selection_page.dart';
import 'package:flutter/material.dart';

enum CreditItem { credit, points, package }

enum SelectionItem { shop, services, post }

enum PlantsType {
  plant1,
  plant2,
  plant3,
  plant4,
  plant5;

  String get buttonIconPath {
    switch (this) {
      case PlantsType.plant1:
        return 'assets/images/button_icon_1.png';
      case PlantsType.plant2:
        return 'assets/images/button_icon_2.png';
      case PlantsType.plant3:
        return 'assets/images/button_icon_3.png';
      case PlantsType.plant4:
        return 'assets/images/button_icon_4.png';
      case PlantsType.plant5:
        return 'assets/images/button_icon_5.png';
    }
  }

  String get shopPlantIconPath {
    switch (this) {
      case PlantsType.plant1:
        return 'assets/images/shop_plants_icon_1.png';
      case PlantsType.plant2:
        return 'assets/images/shop_plants_icon_2.png';
      case PlantsType.plant3:
        return 'assets/images/shop_plants_icon_3.png';
      case PlantsType.plant4:
        return 'assets/images/shop_plants_icon_4.png';
      case PlantsType.plant5:
        return 'assets/images/shop_plants_icon_5.png';
    }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppointmentDataModel _appointmentData;
  late List<NewServicesDataModel> _newServicesData;
  late List<NewServicesDataModel> _trendingDiscoveriesData;
  late List<LocationDataModel> _locations;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeHeader(model: _appointmentData),
            _buildCarousel(),
            _buildSelection(),
            _buildPlantTypeSection(),
            HomeNewServicesList(data: _newServicesData),
            HomeTrendingDiscoveriesGrid(data: _trendingDiscoveriesData),
            HomeFooter(locations: _locations),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      height: 250,
      child: PageView(
        children: [
          Image.asset('assets/images/home_banner.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/home_banner.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/home_banner.jpg', fit: BoxFit.cover),
        ],
      ),
    );
  }

  Widget _buildSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        spacing: 18,
        children: SelectionItem.values.map((item) {
          return Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        SelectionPage(title: item.name.toUpperCase()),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF41745E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                item.name.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPlantTypeSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: PlantsType.values.map((plantType) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(plantType.buttonIconPath, width: 80, height: 80),
          );
        }).toList(),
      ),
    );
  }

  void _loadData() {
    setState(() {
      _appointmentData = AppointmentDataModel(
        appointmentDate: DateTime(2020, 10, 14, 12, 30),
        location: '123 Flower St, Bloomtown',
      );

      _newServicesData = List.filled(
        3,
        NewServicesDataModel(
          imagePath: 'assets/images/image_1.jpg',
          tooltip: 'Lorem Ipsum',
          title: 'Lorem ipsum dolor sit amet consectetur',
          price: 10,
        ),
      );

      _trendingDiscoveriesData = List.generate(8, (index) {
        return NewServicesDataModel(
          imagePath: 'assets/images/image_1.jpg',
          tooltip: 'Lorem ipsum',
          title: index.isEven
              ? 'Lorem ipsum dolor sit amet consectetur adipiscing elit'
              : 'Lorem ipsum dolor sit amet consectetur adipiscing elit. Lorem ipsum dolor sit amet',
        );
      });

      _locations = [
        LocationDataModel(
          name: 'Sunway Pyramid',
          address:
              '10 Floor, Lorem Ipsum Mall, Jalan ss23 Lorem, Selangor, Malaysia',
          startHour: '10 AM',
          endHour: '10 PM',
        ),
        LocationDataModel(
          name: 'The Gardens Mall',
          address:
              '10 Floor, Lorem Ipsum Mall, Jalan ss23 Lorem, Selangor, Malaysia',
          startHour: '10 AM',
          endHour: '10 PM',
        ),
      ];
    });
  }
}
