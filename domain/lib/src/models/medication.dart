class Medication {
  final int id;
  final String name;
  final bool isSplittable;

  const Medication({
    required this.id,
    required this.name,
    required this.isSplittable,
  });

  const Medication.empty()
      : id = 0,
        name = '',
        isSplittable = false;
}
