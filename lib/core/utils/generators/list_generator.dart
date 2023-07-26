class ListGeneratorFromMap<T> {
  List<T> generateToList(Map<String, dynamic> mapJson) {
    final List<T> list = (mapJson as List)
        .map<T>(
          (element) => element.fromMapJson(element),
        )
        .toList();
    return list;
  }
}
