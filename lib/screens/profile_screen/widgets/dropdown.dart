part of '../profile_screen.dart';

class Dropdown extends StatelessWidget {
  const Dropdown({
    Key? key,
    required this.locale,
  }) : super(key: key);

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${AppLocalizations.of(context)!.changeLanguage}:',
          style: TextStyles.style14.copyWith(
            color: Colors.grey.shade500,
          ),
        ),
        Row(
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
                borderRadius: BorderRadius.circular(13),
                value: locale,
                items: L10n.all.map((locale) {
                  final country = L10n.language(locale.languageCode);
                  return DropdownMenuItem(
                    value: locale,
                    onTap: () {
                      final provider =
                          Provider.of<LocaleProvider>(context, listen: false);
                      provider.setLocale(locale);
                    },
                    child: Center(
                      child: Text(
                        country,
                        style: TextStyles.style14,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            )
          ],
        ),
      ],
    );
  }
}
