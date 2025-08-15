import 'package:flower_shop_app/model/new_services_data_model.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.service, this.cardWidth = 180});

  final NewServicesDataModel service;
  final double cardWidth;

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
    return Stack(
      children: [
        Container(
          width: cardWidth,
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (service.imagePath != null)
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.asset(
                    service.imagePath!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'RM ${service.price?.toStringAsFixed(2) ?? '0.00'}',
                      style: TextStyle(
                        fontSize: hasDiscount ? 12 : 14,
                        fontWeight: hasDiscount
                            ? FontWeight.normal
                            : FontWeight.bold,
                        color: hasDiscount ? Color(0xFF707070) : Colors.green,
                        decoration: hasDiscount
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    if (service.discountedPrice != null)
                      Text(
                        'RM ${service.discountedPrice?.toStringAsFixed(2) ?? '0.00'}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (hasDiscount) _buildDiscountBadge(),
      ],
    );
  }

  Widget _buildDiscountBadge() {
    if (!hasDiscount) return SizedBox.shrink();

    return Positioned(
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
    );
  }
}
