import 'package:flutter/material.dart';
import 'package:flower_shop_app/model/new_services_data_model.dart';

class MallDetailsPage extends StatelessWidget {
  final NewServicesDataModel service;

  const MallDetailsPage({super.key, required this.service});

  bool get hasDiscount =>
      service.discountedPrice != null &&
      service.price != null &&
      service.discountedPrice! < service.price!;

  double get discountPercentage {
    if (hasDiscount && service.price != null) {
      return ((service.price! - service.discountedPrice!) / service.price!) *
          100;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (service.imagePath != null && service.imagePath!.isNotEmpty)
              _buildImageSection(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (service.tooltip != null && service.tooltip!.isNotEmpty)
                    Text(
                      service.tooltip!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    service.title ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (service.price != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RM ${service.price?.toStringAsFixed(2) ?? '0.00'}',
                          style: hasDiscount
                              ? _discountedTextStyle
                              : _defaultTextStyle,
                        ),
                        if (service.discountedPrice != null)
                          Text(
                            'RM ${service.discountedPrice?.toStringAsFixed(2) ?? '0.00'}',
                            style: _defaultTextStyle,
                          ),
                      ],
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        Image.asset(
          service.imagePath ?? '',
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        ),
        if (hasDiscount)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: Color(0xFF244B3A),
                shape: BoxShape.circle,
              ),
              child: Text(
                '${discountPercentage.toStringAsFixed(0)}%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  TextStyle get _defaultTextStyle {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xFF00894D),
    );
  }

  TextStyle get _discountedTextStyle {
    return const TextStyle(
      fontSize: 12,
      color: Color(0xFF707070),
      decoration: TextDecoration.lineThrough,
    );
  }
}
