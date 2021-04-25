class TempConverter {
  double convertToF(double temp) {
    return (temp * 9 / 5) + 32;
  }

  double convertToC(double temp) {
    return (temp - 32) * 5/9;
  }
}
