import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Functions {
  String convertToAgo(DateTime input, context) {
    Duration timeAgo = DateTime.now().difference(input);

    if (timeAgo.inDays >= 1) {
      return '${timeAgo.inDays} ${AppLocalizations.of(context)!.daysAgo}';
    } else if (timeAgo.inHours >= 1) {
      return '${timeAgo.inHours} ${AppLocalizations.of(context)!.hourAgo}';
    } else if (timeAgo.inMinutes >= 1) {
      return '${timeAgo.inMinutes} ${AppLocalizations.of(context)!.minAgo}';
    } else if (timeAgo.inSeconds >= 1) {
      return '${timeAgo.inSeconds} ${AppLocalizations.of(context)!.secAgo}';
    } else {
      return AppLocalizations.of(context)!.justNow;
    }
  }
}
