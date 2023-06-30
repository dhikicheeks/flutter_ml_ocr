import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter_ml_ocr/domain/ocr_ktp/ocr_ktp_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/ocr_ktp/ocr_ktp_repo.dart';

part 'ocr_ktp_state.dart';
part 'ocr_ktp_cubit.freezed.dart';

@injectable
class OcrKtpCubit extends Cubit<OcrKtpState> {
  final IOcrKtp _iOcrKtp;
  OcrKtpCubit(this._iOcrKtp) : super(OcrKtpState.initial());

  void generateDataOcrKtpCubit(XFile image) async {
    emit(const OcrKtpState.generateDataOcrKtpLoading());
    try {
      final result = await _iOcrKtp.generateDataOcrKtp(image);
      result.fold(
            (l) => emit(OcrKtpState.generateDataOcrKtpFailed(l)),
            (r) => emit(OcrKtpState.generateDataOcrKtpSuccess(r)),
      );
    } catch (e) {
      emit(OcrKtpState.generateDataOcrKtpFailed(e.toString()));
    }
  }
}