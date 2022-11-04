import 'package:flutter/material.dart';
import 'package:jake_github/src/core/constants/style.dart';
import 'package:jake_github/src/core/utils/snackBar.dart';
import 'package:jake_github/src/ui/pages/home/home_view.dart';
import 'package:jake_github/src/ui/pages/home/home_vm.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'biometric_scan_vm.dart';

class BioMetricScanView extends StatelessWidget {
  const BioMetricScanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bio-Metric Scan'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LottieBuilder.asset('assets/lotties/fingerprint_scanning.json'),
          InkWell(
            onTap: () async {
              bool _isAuth = await BioMetricScanViewModel().hasBiometrics();
              if (_isAuth) {
                bool _isNextScreen =
                    await BioMetricScanViewModel().authenticate();
                _provider.checkCall(context);
                if (_isNextScreen) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const HomeView(),
                      ));
                }
              } else {
                showSnackBar(
                    message: 'Authentication Failed!', context: context);
              }
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'Tap to Scan',
                  style: kTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
