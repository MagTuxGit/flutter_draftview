extension StringExtension on String {
  String validSubstring(int start, int end) {
    bool isFirstUtf16Surrogate(int value) {
      return value & 0xFC00 == 0xD800;
    }

    bool isSecondUtf16Surrogate(int value) {
      return value & 0xFC00 == 0xDC00;
    }

    final int startIndex = () {
      if (isSecondUtf16Surrogate(this.codeUnitAt(start))) {
        return start + 1;
      }
      return start;
    }();

    final int endIndex = () {
      if (isFirstUtf16Surrogate(this.codeUnitAt(end - 1))) {
        return end + 1;
      }
      return end;
    }();
    return this.substring(startIndex, endIndex);
  }
}
