class Prompt {
  final int id;
  final String left;
  final String right;

  const Prompt({required this.id, required this.left, required this.right});
  dynamic operator [](String key) {
    if (key == 'left') return left;
    if (key == 'right') return right;
    if (key == 'id') return id;
    return null;
  }

  factory Prompt.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'left': String left, 'right': String right} => Prompt(
        id: id,
        left: left,
        right: right,
      ),
      _ => throw const FormatException('Failed to load'),
    };
  }
}
