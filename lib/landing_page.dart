import 'package:flutter/material.dart';
import 'common_drawer.dart';

class LandingPage extends StatelessWidget {
  static const String routeName = '/landing_page';

  @override
  Widget build(BuildContext context) {
    return CommonDrawer(
      currentPage: '/',
      appBarSubtitle: 'Home',
      bodyContent: _buildLandingPageBody(),
    );
  }

  /// Builds the main body of the LandingPage.
  ///
  /// Includes the centered logo image and any additional content.
  Widget _buildLandingPageBody() {
    return Container(
      color: Colors.black, // Set the background color to black
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Centered Logo
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/tcg_assistant_logo.png',
                fit: BoxFit.contain,
              ),
            ),
            // Add any additional content here
          ],
        ),
      ),
    );
  }
}
