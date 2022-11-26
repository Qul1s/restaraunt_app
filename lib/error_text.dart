String? errorText(dynamic controller) {
  final text = controller.value.text;
  if (text.isEmpty) {
    return 'Введіть текст';
  }
  if (text.length < 4) {
    return 'Занадто мало символів';
  }

  return null;
}