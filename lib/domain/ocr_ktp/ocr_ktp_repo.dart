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
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();

    try {
      for (int i = 0; i < recognisedText.blocks.length; i++) {
        for (int j = 0; j < recognisedText.blocks[i].lines.length; j++) {
          for (int k = 0;
          k < recognisedText.blocks[i].lines[j].elements.length;
          k++) {
            final data = recognisedText.blocks[i].lines[j].elements[k];

            print("b$i l$j e$k " +
                data.text.toLowerCase().trim().replaceAll(" ", "") +
                " " +
                data.rect.center.toString());

            if (checkNikField(data.text)) {
              nikRect = data.rect;
              print("nik field detected");
            }

            if (checkNamaField(data.text)) {
              namaRect = data.rect;
              print("nama field detected");
            }

            if (checkTglLahirField(data.text)) {
              tempatTanggalLahirRect = data.rect;
              print("tempat tgllahir field detected");
            }

            if (checkJenisKelaminField(data.text)) {
              jenisKelaminRect = data.rect;
              print("jenis kelamin field detected");
            }

            if (checkAlamatField(data.text)) {
              alamatRect = data.rect;
              print("alamat field detected");
            }

            if (checkRtRwField(data.text)) {
              rtrwRect = data.rect;
              print("RT/RW field detected");
            }

            if (checkKelDesaField(data.text)) {
              kelDesaRect = data.rect;
              print("kelurahan / desa field detected");
            }

            if (checkKecamatanField(data.text)) {
              kecamatanRect = data.rect;
              print("kecamatan field detected");
            }

            if (checkAgamaField(data.text)) {
              agamaRect = data.rect;
              print("agama field detected");
            }

            if (checkKawinField(data.text)) {
              statusKawinRect = data.rect;
              print("statusKawin field detected");
            }

            if (checkPekerjaanField(data.text)) {
              pekerjaanRect = data.rect;
              print("pekerjaan field detected");
            }

            if (checkKewarganegaraanField(data.text)) {
              kewarganegaraanRect = data.rect;
              print("kewarganegaraan field detected");
            }
          }
        }
      }
    } catch (e) {
      print(e);
      throw Exception("check fields failed ");
    }

    try {
      for (int i = 0; i < recognisedText.blocks.length; i++) {
        for (int j = 0; j < recognisedText.blocks[i].lines.length; j++) {
          final data = recognisedText.blocks[i].lines[j];

          if (isInside(data.rect, nikRect)) {
            nikResult = nikResult + " " + data.text;
            print("------ nik");
            print(nikResult);
          }

          if (isInside3rect(
              isThisRect: data.rect,
              isInside: namaRect,
              andAbove: tempatTanggalLahirRect)) {
            if (data.text.toLowerCase() != "nama") {
              print("------ name");
              nameResult = (nameResult + " " + data.text).trim();
              print(nameResult);
            }
          }

          if (isInside(data.rect, tempatTanggalLahirRect)) {
            final temp = data.text.replaceAll("Tempat/Tgi Lahir", "");
            tempatLahirResult = temp.substring(0, temp.indexOf(',') + 1);
            print("------ tempat lahir");
            print(tempatLahirResult);
          }

          if (isInside(data.rect, tempatTanggalLahirRect)) {
            final temp = data.text.replaceAll("Tempat/Tgi Lahir", "");
            final result = temp.substring(0, temp.indexOf(',') + 1);
            print(result);
            if (result.isNotEmpty) {
              tglLahirResult =
                  temp.replaceAll(result, "").replaceAll(":", "").trim();
            }

            print("------ tgllahir");
            print(tglLahirResult);
          }

          if (isInside(data.rect, jenisKelaminRect)) {
            jenisKelaminResult = jenisKelaminResult + " " + data.text;
            print("------ jenis kelamin ");
            print(rtrwResult);
          }

          if (isInside3rect(
              isThisRect: data.rect,
              isInside: alamatRect,
              andAbove: agamaRect)) {
            alamatFullResult = alamatFullResult + " " + data.text;
            print("------ alamat");
            print(alamatFullResult);
          }

          if (isInside(data.rect, alamatRect)) {
            alamatResult = alamatResult + " " + data.text;
            print("------ alamat  ");
            print(alamatResult);
          }

          if (isInside(data.rect, rtrwRect)) {
            rtrwResult = rtrwResult + " " + data.text;
            print("------ rt rw ");
            print(rtrwResult);
          }

          if (isInside(data.rect, kelDesaRect)) {
            kelDesaResult = kelDesaResult + " " + data.text;
            print("------ keldesa");
            print(kelDesaResult);
          }

          if (isInside(data.rect, kecamatanRect)) {
            kecamatanResult = kecamatanResult + " " + data.text;
            print("------ kecamatan");
            print(kecamatanResult);
          }

          if (isInside(data.rect, agamaRect)) {
            agamaResult = agamaResult + " " + data.text;
            print("------ agama : $agamaResult");
          }

          if (isInside(data.rect, statusKawinRect)) {
            statusKawinResult = statusKawinResult + " " + data.text;
            print("------ status kawin result ");
            print(statusKawinResult);
          }

          if (isInside(data.rect, pekerjaanRect)) {
            pekerjaanResult = pekerjaanResult + " " + data.text;
            print("------ status pekerjaan result ");
            print(pekerjaanResult);
          }

          if (isInside(data.rect, kewarganegaraanRect)) {
            kewarganegaraanResult = kewarganegaraanResult + " " + data.text;
            print("------ status kewarganegaraan result ");
            print(kewarganegaraanResult);
          }
        }
      }
    } catch (e) {
      print(e);
      throw Exception("iteration failed ");
    }

    try {
      OcrKtpModel dataResult = OcrKtpModel(
        nik : normalizeNikText(nikResult),
        namaLengkap : normalizeNamaText(nameResult),
        tanggalLahir : normalizeAlamatText(tglLahirResult),
        alamatFull : normalizeAlamatText(alamatFullResult),
        alamat : normalizeAlamatText(alamatResult),
        rtrw : normalizeAlamatText(rtrwResult),
        kecamatan : normalizeAlamatText(kecamatanResult),
        kelDesa : kelDesaResult, //belum
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