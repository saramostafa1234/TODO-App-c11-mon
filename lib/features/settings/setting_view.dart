import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../core/widget/setting_prov.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  List<String> _languages = ["English", "عربي"];
  List<String> _themes = ["Light", "Dark"];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var lang = AppLocalizations.of(context)!;
    var mediaQuery = MediaQuery.of(context);
    //var provider= SettingsProvider();
    var provider = Provider.of<SettingsProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height * 0.22,
          color: theme.primaryColorLight,
          padding: EdgeInsets.only(
              left: 20, right: 20, top: mediaQuery.size.height * 0.06),
          child: Text(
            lang.settings,
            style: theme.textTheme.bodyLarge!.copyWith(
                color: provider.isDark() ? Color(0xff141922) : Colors.white),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          margin: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lang.language,
                style: theme.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomDropdown<String>(
                items: _languages,
                //============??????????????????????????????????????
                initialItem: provider.currentLanguage == "en"
                    ? _languages[0]
                    : _languages[1],
                onChanged: (value) {
                  if (value == "English") {
                    provider.changeCurrentLanguage("en");
                  }
                  if (value == "عربي") {
                    provider.changeCurrentLanguage("ar");
                  }
                  log("Changing value to: $value");
                },
                decoration: CustomDropdownDecoration(
                  closedFillColor:
                      provider.isDark() ? Color(0xff141a2e) : Colors.white,
                  closedSuffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: provider.isDark()
                        ? theme.primaryColorDark
                        : Colors.black,
                  ),
                  expandedFillColor:
                      provider.isDark() ? Color(0xff141a2e) : Colors.white,
                  expandedSuffixIcon: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: provider.isDark()
                        ? theme.primaryColorDark
                        : Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                lang.theme_mode,
                style: theme.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomDropdown<String>(
                items: _themes,
                initialItem: provider.currentThemeMode == ThemeMode.light
                    ? _themes[0]
                    : _themes[1],
                onChanged: (value) {
                  if (value == "Light") {
                    provider.changeCurrentTheme(ThemeMode.light);
                  }
                  if (value == "Dark") {
                    provider.changeCurrentTheme(ThemeMode.dark);
                  }
                  log("Changing value to: $value");
                },
                decoration: CustomDropdownDecoration(
                  closedFillColor:
                      provider.isDark() ? Color(0xff141a2e) : Colors.white,
                  closedSuffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: provider.isDark()
                        ? theme.primaryColorDark
                        : Colors.black,
                  ),
                  expandedFillColor:
                      provider.isDark() ? Color(0xff141a2e) : Colors.white,
                  expandedSuffixIcon: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: provider.isDark()
                        ? theme.primaryColorDark
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
