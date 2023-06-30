// To parse this JSON data, do
//
//     final ocrKtpModel = ocrKtpModelFromJson(jsonString);

import 'dart:convert';

import 'package:camera/camera.dart';

OcrKtpModel ocrKtpModelFromJson(String str) => OcrKtpModel.fromJson(json.decode(str));

String ocrKtpModelToJson(OcrKtpModel data) => json.encode(data.toJson());

class OcrKtpModel {
  String nik;
  String namaLengkap;
  String tanggalLahir;
  String alamatFull;
  String alamat;
  String rtrw;
  String kecamatan;
  String kelDesa;
  String agama;
  String statusPerkawinan;
  String tempatLahir;
  String jenisKelamin;
  String golDarah;
  String pekerjaan;
  String kewarganegaraan;
  String berlakuHingga;
  XFile fotoKTP;

  OcrKtpModel({
    required this.nik,
    required this.namaLengkap,
    required this.tanggalLahir,
    required this.alamatFull,
    required this.alamat,
    required this.rtrw,
    required this.kecamatan,
    required this.kelDesa,
    required this.agama,
    required this.statusPerkawinan,
    required this.tempatLahir,
    required this.jenisKelamin,
    required this.golDarah,
    required this.pekerjaan,
    required this.kewarganegaraan,
    required this.berlakuHingga,
    required this.fotoKTP,
  });

  factory OcrKtpModel.fromJson(Map<String, dynamic> json) => OcrKtpModel(
    nik: json["nik"],
    namaLengkap: json["namaLengkap"],
    tanggalLahir: json["tanggalLahir"],
    alamatFull: json["alamatFull"],
    alamat: json["alamat"],
    rtrw: json["rtrw"],
    kecamatan: json["kecamatan"],
    kelDesa: json["kelDesa"],
    agama: json["agama"],
    statusPerkawinan: json["statusPerkawinan"],
    tempatLahir: json["tempatLahir"],
    jenisKelamin: json["jenisKelamin"],
    golDarah: json["golDarah"],
    pekerjaan: json["pekerjaan"],
    kewarganegaraan: json["kewarganegaraan"],
    berlakuHingga: json["berlakuHingga"],
    fotoKTP: json["fotoKTP"],
  );

  Map<String, dynamic> toJson() => {
    "nik": nik,
    "namaLengkap": namaLengkap,
    "tanggalLahir": tanggalLahir,
    "alamatFull": alamatFull,
    "alamat": alamat,
    "rtrw": rtrw,
    "kecamatan": kecamatan,
    "kelDesa": kelDesa,
    "agama": agama,
    "statusPerkawinan": statusPerkawinan,
    "tempatLahir": tempatLahir,
    "jenisKelamin": jenisKelamin,
    "golDarah": golDarah,
    "pekerjaan": pekerjaan,
    "kewarganegaraan": kewarganegaraan,
    "berlakuHingga": berlakuHingga,
    "fotoKTP": fotoKTP,
  };
}
