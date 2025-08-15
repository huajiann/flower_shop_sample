import 'package:flower_shop_app/model/new_services_data_model.dart';
import 'package:flower_shop_app/pages/mall/mall_details_page.dart';
import 'package:flower_shop_app/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class MallPage extends StatefulWidget {
  const MallPage({super.key});

  @override
  State<MallPage> createState() => _MallPageState();
}

class _MallPageState extends State<MallPage> {
  List<NewServicesDataModel> _newServicesData = [];

  final List<String> _availableFilters = [
    'Salon',
    'Spa',
    'Home Service',
    'Delivery',
  ];
  final Set<String> _selectedFilters = {};
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Filters'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _availableFilters.map((filter) {
                    return CheckboxListTile(
                      value: _selectedFilters.contains(filter),
                      title: Text(filter),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (checked) {
                        setState(() {
                          if (checked == true) {
                            _selectedFilters.add(filter);
                          } else {
                            _selectedFilters.remove(filter);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: mallAppBar(context),
      body: Column(children: [Expanded(child: _buildMallGrid())]),
    );
  }

  PreferredSizeWidget mallAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      centerTitle: false,
      elevation: 6,
      shadowColor: const Color(0x1A000000),
      title: Container(
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            hintText: 'Search Salon',
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Image.asset(
                'assets/images/icon_search.png',
                width: 20,
                height: 20,
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => _showFilterDialog(context),
                child: Image.asset(
                  'assets/images/icon_filter.png',
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  Widget _buildMallGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        const int columns = 2;
        const horizontalPadding = 20.0 * 2;
        const crossAxisSpacing = 10.0;
        final cardWidth =
            (width - horizontalPadding - crossAxisSpacing) / columns;
        final rows = (_newServicesData.length / columns).ceil();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: LayoutGrid(
            columnSizes: [1.fr, 1.fr],
            rowSizes: List.generate(rows, (_) => auto),
            rowGap: 10,
            columnGap: crossAxisSpacing,
            children: [
              for (final service in _newServicesData)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MallDetailsPage(service: service),
                      ),
                    );
                  },
                  child: ItemCard(service: service, cardWidth: cardWidth),
                ),
            ],
          ),
        );
      },
    );
  }

  void _loadData() {
    setState(() {
      _newServicesData = List.generate(8, (index) {
        return NewServicesDataModel(
          imagePath: 'assets/images/image_1.jpg',
          tooltip: 'Lorem ipsum',
          title: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
          price: 100,
          discountedPrice: index.isEven ? null : 50,
        );
      });
    });
  }
}
