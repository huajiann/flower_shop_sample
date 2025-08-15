import 'package:flower_shop_app/model/location_data_model.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeFooter extends StatefulWidget {
  const HomeFooter({super.key, required this.locations});

  final List<LocationDataModel> locations;

  @override
  State<HomeFooter> createState() => _HomeFooterState();
}

class _HomeFooterState extends State<HomeFooter> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    final String html = '''
<!doctype html>
<html lang="en"><head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Google Maps</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>
<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3984.080491541948!2d101.6075559!3d3.0731724!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31cc4c8776586d9b%3A0x5e19a549d4f26f25!2sSunway%20Pyramid%20Shopping%20Mall!5e0!3m2!1sen!2smy!4v1755193906056!5m2!1sen!2smy" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
    ''';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(html);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 32),
        _buildLocation(),
        SizedBox(height: 16),
        _buildLocationList(),
      ],
    );
  }

  Widget _buildLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Location'.toUpperCase(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 200,
              child: WebViewWidget(controller: _controller),
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildLocationList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        spacing: 26,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.locations.map((location) {
          return _buildLocationItem(location);
        }).toList(),
      ),
    );
  }

  Widget _buildLocationItem(LocationDataModel location) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          location.name ?? '',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/icon_location.png',
                width: 12,
                color: Colors.black,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  location.address ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF46A0BF),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF46A0BF),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/icon_clock_1.png', width: 12),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                '${location.startHour ?? ''} - ${location.endHour ?? ''}',
                style: TextStyle(fontSize: 14, color: Color(0xFF707070)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
