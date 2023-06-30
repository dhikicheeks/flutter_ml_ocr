part of 'ocr_ktp_cubit.dart';

@freezed
class OcrKtpState with _$OcrKtpState {
  const factory OcrKtpState.initial() = _Initial;
  const factory OcrKtpState.generateDataOcrKtpSuccess(OcrKtpModel generateDataOcrKtpResp) = _GenerateDataOcrKtpSuccess;
  const factory OcrKtpState.generateDataOcrKtpLoading() = _GenerateDataOcrKtpLoading;
  const factory OcrKtpState.generateDataOcrKtpFailed(String error) = _GenerateDataOcrKtpFailed;
}