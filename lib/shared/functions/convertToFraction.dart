String formatDoubleToFractionToText(int total, double percent) {
  percent = percent * 100;

  double fractionNumerator = (total * percent) / 100;

  return '$fractionNumerator / $total';
}

double getPercentageOfOneFromTotal(int total) {
  return (1 / total);
}