class TempUtil {
  String getTempInF(double temp) {
     final tempF = (temp * 9 / 5) + 32;
     return tempF.toStringAsFixed(2) + ' °F';
  }
  
  String getTempInC(double temp) {
    return temp.toStringAsFixed(2) + ' °C';
  }
}
