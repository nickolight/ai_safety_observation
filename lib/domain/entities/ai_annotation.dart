class AIAnnotation {
  final String label;
  final Duration startTimestamp;
  final Duration endTimestamp;

  const AIAnnotation({
    required this.label,
    required this.startTimestamp,
    required this.endTimestamp,
  });
}
