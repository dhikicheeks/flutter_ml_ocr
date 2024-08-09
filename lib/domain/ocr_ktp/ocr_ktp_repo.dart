import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ml_ocr/domain/ocr_ktp/ocr_ktp_model.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:injectable/injectable.dart';

import '../../utils/ocr_ktp/checkFields.dart';
import '../../utils/ocr_ktp/normalizations.dart';

abstract class IOcrKtp {
  Future<Either<String, OcrKtpModel>> generateDataOcrKtp(XFile image);
}

@LazySingleton(as: IOcrKtp)
class IOcrKtpRepo extends IOcrKtp {

  @override
  Future<Either<String, OcrKtpModel>> generateDataOcrKtp(XFile image) async {

    String nikResult = "";
    String nameResult = "";
    String tempatLahirResult = "";
    String tglLahirResult = "";
    String jenisKelaminResult = "";
    String alamatFullResult = "";
    String alamatResult = "";
    String rtrwResult = "";
    String kelDesaResult = "";
    String kecamatanResult = "";
    String agamaResult = "";
    String statusKawinResult = "";
    String pekerjaanResult = "";
    String kewarganegaraanResult = "";
    String golDarahResult = "";
    String berlakuHinggaResult = "";

    Rect? nikRect;
    Rect? namaRect;
    Rect? alamatRect;
    Rect? rtrwRect;
    Rect? kelDesaRect;
    Rect? kecamatanRect;
    Rect? jenisKelaminRect;
    Rect? tempatTanggalLahirRect;
    Rect? agamaRect;
    Rect? statusKawinRect;
    Rect? pekerjaanRect;
    Rect? kewarganegaraanRect;

    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.barcodeScanner();
    RecognizedText recognisedText = await textDetector.processImage(inputImage) as RecognizedText;
    await textDetector.close();

    try {
      OcrKtpModel dataResult = OcrKtpModel(
        nik : normalizeNikText(nikResult),
        namaLengkap : normalizeNamaText(nameResult),
        tanggalLahir : normalizeAlamatText(tglLahirResult),
        alamatFull : normalizeAlamatText(alamatFullResult),
        alamat : normalizeAlamatText(alamatResult),
        rtrw : normalizeAlamatText(rtrwResult),
        kecamatan : normalizeAlamatText(kecamatanResult),
        kelDesa : normalizeAlamatText(kelDesaResult),
        agama : normalizeAgamaText(agamaResult),
        statusPerkawinan : normalizeKawinText(statusKawinResult),
        tempatLahir : tempatLahirResult, //belum
        jenisKelamin : normalizeJenisKelaminText(jenisKelaminResult),
        golDarah : golDarahResult, //belum
        pekerjaan : normalizePekerjaanText(pekerjaanResult),
        kewarganegaraan : normalizeKewarganegaraanText(kewarganegaraanResult),
        berlakuHingga : berlakuHinggaResult, //belum
        fotoKTP: image
      );

      return right(dataResult);
    } catch (e) {
      return left(e.toString());
    }
  }
}