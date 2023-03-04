String formatDoubleToFractionToText(int total, double percent) {
  percent = percent * 100;

  num fractionNumerator = (total * percent) / 100;

  return '${(fractionNumerator.toInt())} / $total';
}

double getPercentageOfOneFromTotal(int total) {
  return (1 / total);
}