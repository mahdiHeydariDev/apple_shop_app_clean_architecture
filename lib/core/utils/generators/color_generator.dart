//NOTE: This function receives the color code as a string and returns it as a HEX code.
///instructions:Color(colorGenerator(color:'example color'));
int colorGenerator({required String color}) {
  if (color.isNotEmpty) {
    final String stringColor = 'ff$color';
    final int orgColor = int.parse(stringColor, radix: 16);
    return orgColor;
  } else {
    const String blackColor = 'ff000000';
    final int blackInt = int.parse(blackColor, radix: 16);
    return blackInt;
  }
}
