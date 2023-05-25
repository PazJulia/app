import 'dart:convert';

String extractErrorMessage(responseBody) {
  final Map<String, dynamic> errorData = json.decode(responseBody);
  String errorMessage = errorData['stack'];
  int startIndex = errorMessage.indexOf(':') + 1;
  return errorMessage.substring(startIndex).trim();
}
