extension ExtractFromQuery on String {
  String? extract(String key) {
    int queryStartIndex = indexOf('?');
    if (queryStartIndex == -1) return null;

    String query = substring(queryStartIndex + 1);

    // Split the query into key-value pairs
    List<String> pairs = query.split('&');

    // Find the key-value pair that matches the given key
    for (String pair in pairs) {
      List<String> keyValue = pair.split('=');
      if (keyValue.length == 2) {
        String currentKey = keyValue[0];
        String value = keyValue[1];

        if (currentKey == key) {
          // Decode the URL-encoded value
          return Uri.decodeComponent(value);
        }
      }
    }

    return null;
  }
}

extension ColorParser on String {
  int convertToColor() {
    if (isNotEmpty) {
      final String stringColor = 'ff$this';
      final int orgColor = int.parse(stringColor, radix: 16);
      return orgColor;
    } else {
      const String blackColor = 'ff000000';
      final int blackInt = int.parse(blackColor, radix: 16);
      return blackInt;
    }
  }
}
