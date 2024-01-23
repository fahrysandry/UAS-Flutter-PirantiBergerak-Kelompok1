String getInitials(String name) {
  List<String> names = name.split(' ');
  String initials = '';
  int numWords = names.length >= 2 ? 2 : names.length;

  for (int i = 0; i < numWords; i++) {
    initials += names[i][0].toUpperCase();
  }

  return initials;
}
