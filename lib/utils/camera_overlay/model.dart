enum OverlayFormat {
  /// M-Banking
  cardID1,

  /// Visa
  cardID2,

  /// ID CARD
  cardID3,

  /// SIM CARD
  simID000
}
enum OverlayOrientation { landscape, portrait }

abstract class OverlayModel {
  ///ratio between maximum allowable lengths of shortest and longest sides
  double? ratio;

  ///ratio between maximum allowable radius and maximum allowable length of shortest side
  double? cornerRadius;

  ///natural orientation for overlay
  OverlayOrientation? orientation;
}

class CardOverlay implements OverlayModel {
  CardOverlay({
    this.ratio = 1.5,
    this.cornerRadius = 0.66,
    this.orientation = OverlayOrientation.landscape,
  });

  @override
  double? ratio;
  @override
  double? cornerRadius;
  @override
  OverlayOrientation? orientation;

  static byFormat(OverlayFormat format) {
    switch (format) {
      case (OverlayFormat.cardID1):
        return CardOverlay(ratio: 1.59, cornerRadius: 0.064);
      case (OverlayFormat.cardID2):
        return CardOverlay(ratio: 1.42, cornerRadius: 0.067);
      case (OverlayFormat.cardID3):
        return CardOverlay(ratio: 1.42, cornerRadius: 0.057);
      case (OverlayFormat.simID000):
        return CardOverlay(ratio: 1.66, cornerRadius: 0.073);
    }
  }
}