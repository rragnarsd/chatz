class Functions {
  String convertToAgo(DateTime input) {
    Duration timeAgo = DateTime.now().difference(input);

    if (timeAgo.inDays >= 1) {
      return '${timeAgo.inDays} day(s) ago';
    } else if (timeAgo.inHours >= 1) {
      return '${timeAgo.inHours} hour(s) ago';
    } else if (timeAgo.inMinutes >= 1) {
      return '${timeAgo.inMinutes} min(s) ago';
    } else if (timeAgo.inSeconds >= 1) {
      return '${timeAgo.inSeconds} sec(s) ago';
    } else {
      return 'just now';
    }
  }
}
