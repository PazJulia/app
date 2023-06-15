Set<Map<String, dynamic>> retornarExplicacaoTextoCodigoFormatada(String texto) {
  Set<Map<String, dynamic>> elements = {};
  List<String> parts = texto.split('@{code}');
  bool isCode = false;

  for (String part in parts) {
    if (part.isNotEmpty) {
      elements.add({'texto': part, 'isCode': isCode});
    }
    isCode = !isCode;
  }

  return elements;
}