// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/ocr_ktp/ocr_ktp_model.dart';

class ResultKtpPage extends StatefulWidget {
  OcrKtpModel generateDataOcrKtpResp;
  ResultKtpPage({Key? key, required this.generateDataOcrKtpResp}) : super(key: key);

  @override
  State<ResultKtpPage> createState() => _ResultKtpPageState();
}

class _ResultKtpPageState extends State<ResultKtpPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Hasil Pemindaian KTP"),
      ),
      body: ListView(
        children: [
          Center(
            child: Image.file(
              File(widget.generateDataOcrKtpResp.fotoKTP.path),
            ),
          ),

          Text(
            'NIK: '+ widget.generateDataOcrKtpResp.nik,
            style: TextStyle(fontSize: 20),
          ),

          Text(
            'Nama: '+ widget.generateDataOcrKtpResp.namaLengkap,
            style: TextStyle(fontSize: 20),
          ),

          Text(
            'Tempat/Tgl lahir: '+ widget.generateDataOcrKtpResp.tempatLahir + widget.generateDataOcrKtpResp.tanggalLahir,
            style: TextStyle(fontSize: 20),
          ),

          Text(
            'Alamat: '+ widget.generateDataOcrKtpResp.alamat,
            style: TextStyle(fontSize: 20),
          ),

          Text(
            'RT/RW: '+ widget.generateDataOcrKtpResp.rtrw,
            style: TextStyle(fontSize: 20),
          ),

          Text(
            'Kel/Des: '+ widget.generateDataOcrKtpResp.kelDesa,
            style: TextStyle(fontSize: 20),
          ),

          Text(
            'Kecamatan: '+ widget.generateDataOcrKtpResp.kecamatan,
            style: TextStyle(fontSize: 20),
          ),

          Text(
            'Agama: '+ widget.generateDataOcrKtpResp.agama,
            style: TextStyle(fontSize: 20),
          ),

          Text(
            'Status Perkawinan: '+ widget.generateDataOcrKtpResp.statusPerkawinan,
            style: TextStyle(fontSize: 20),
          ),

          Text(
            'Pekerjaan: '+ widget.generateDataOcrKtpResp.pekerjaan,
            style: TextStyle(fontSize: 20),
          ),

          Text(
            'Kewarganegaraan: '+ widget.generateDataOcrKtpResp.kewarganegaraan,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}