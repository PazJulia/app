String formatDoubleToFractionToText(int total, double percent) {
  percent = percent * 100;

  num fractionNumerator = (total * percent) / 100;

  // round to the nearest integer
  fractionNumerator = fractionNumerator.round();
  return '${(fractionNumerator.toInt())} / $total';
}

double getPercentageOfOneFromTotal(int total) {
  return (1 / total);
}