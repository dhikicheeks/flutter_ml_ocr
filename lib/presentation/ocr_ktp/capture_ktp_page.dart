import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ml_ocr/application/ocr_ktp/ocr_ktp_cubit.dart';
import 'package:flutter_ml_ocr/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../utils/camera_overlay/camera_overlay.dart';
import '../../utils/camera_overlay/model.dart';
import 'result_ktp_page.dart';

class CaptureKtpPage extends StatefulWidget {
  const CaptureKtpPage({Key? key}) : super(key: key);

  @override
  State<CaptureKtpPage> createState() => _CaptureKtpPageState();
}

class _CaptureKtpPageState extends State<CaptureKtpPage> {
  var generateDataOcrKtpCubit = getIt<OcrKtpCubit>();

  ScreenshotController screenshotController = ScreenshotController();
  OverlayFormat format = OverlayFormat.cardID3;
  late BuildContext popupContext;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => generateDataOcrKtpCubit,
          child: BlocConsumer<OcrKtpCubit, OcrKtpState>(
            listener: (context, state) {
              state.maybeMap(
                  orElse: () {},
                  generateDataOcrKtpSuccess: (result){
                    Navigator.pop(popupContext);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResultKtpPage(generateDataOcrKtpResp: result.generateDataOcrKtpResp,)),
                    );
                  }
              );
            },
            builder: (context, state) {
              return state.maybeMap(
                orElse: () => FutureBuilder<List<CameraDescription>?>(
                  future: availableCameras(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == null) {
                        return Align(
                          alignment: Alignment.center,
                          child: Text(
                            'No camera found',
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }
                      return CameraOverlay(
                        snapshot.data!.first,
                        CardOverlay.byFormat(format), (XFile file) => showDialog(
                        context: context,
                        barrierColor: Colors.black,
                        builder: (context) {
                          popupContext = context;
                          CardOverlay overlay = CardOverlay.byFormat(format);
                          return AlertDialog(
                            actionsAlignment: MainAxisAlignment.center,
                            backgroundColor: Colors.black,
                            title: const Text(
                              'Pastikan KTP kamu sudah benar ya gan',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              OutlinedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () => getPictureScreen(),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                              )
                            ],
                            content: SizedBox(
                              width: double.infinity,
                              child: Screenshot(
                                controller: screenshotController,
                                child: AspectRatio(
                                  aspectRatio: overlay.ratio!,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        alignment: FractionalOffset.center,
                                        image: FileImage(
                                          File(file.path),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                        info: 'Pastikan posisi KTP tepat berada digaris kotak agar kami dapat memindai dengan benar',
                        label: 'Memindai KTP kamu',
                      );
                    } else {
                      return const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Fetching cameras',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> getPictureScreen() {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String getRandomString(int length) => String.fromCharCodes(
      Iterable.generate(
        length, (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );

    return screenshotController.capture(delay: Duration(milliseconds: 10)).then((capturedImage) async {
      String randName = getRandomString(5);
      final directory = (await getApplicationDocumentsDirectory()).path;
      File imgFile = new File('$directory/$randName.png');
      imgFile.writeAsBytes(capturedImage!).then((value) async {
        XFile file = new XFile(imgFile.path);
        return generateDataOcrKtpCubit.generateDataOcrKtpCubit(file);
      }).catchError((onError) {
        print(onError);
      });
    }).catchError((onError) {
      print(onError);
    });
  }
}
