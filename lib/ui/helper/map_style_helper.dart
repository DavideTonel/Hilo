class MapStyleHelper {
  MapStyleHelper._();

  static final MapStyleHelper instance = MapStyleHelper._();

  String getLightPresetFromTime(DateTime dateTime) {
    if (dateTime.hour >= 6 && dateTime.hour < 12) {
      return "dawn";
    } else if (dateTime.hour >= 12 && dateTime.hour < 18) {
      return "day";
    } else if (dateTime.hour >= 18 && dateTime.hour < 21) {
      return "dusk";
    } else {
      return "night";
    }
  }
}
