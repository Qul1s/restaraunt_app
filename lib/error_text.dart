String? errorText(dynamic _controller) {
  final text = _controller.value.text;
  if (text.isEmpty) {
    return 'Введіть текст';
  }
  if (text.length < 4) {
    return 'Занадто мало символів';
  }
  // return null if the text is valid
  return null;
}