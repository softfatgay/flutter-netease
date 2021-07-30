import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/widget/app_bar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: '二维码',
      ).build(context),
      body: Stack(
        children: <Widget>[
          _buildQrView(context),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 70,
            left: 0,
            right: 0,
            child: Text(
              '将二维码放入框内即可自动扫描',
              style: t12grey,
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: GestureDetector(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0x4D000000)),
                      child: Image.asset(
                        'assets/images/flash_icon.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '照明',
                      style: t12white,
                    ),
                  ],
                ),
              ),
              onTap: () async {
                await controller?.toggleFlash();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = 220.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: backWhite,
          borderRadius: 2,
          cutOutBottomOffset: 150,
          borderLength: 20,
          borderWidth: 1,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        print('----------------');
        print(scanData);
        if (scanData != null) {
          Routers.push(Routers.qrCodeResultPage, context, {'result': scanData});
          // print(scanData.code.toString());
          // Toast.show('${scanData.code.toString()}', context);
        }
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
