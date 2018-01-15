https://pub.dartlang.org/packages/intl

```
flutter packages pub run intl_translation:extract_to_arb --output-dir=lib/i18n lib/i18n/strings.dart
```

To rebuild the i18n files:

```
flutter packages pub run intl_translation:generate_from_arb \
  --output-dir=lib/i18n \
  --no-use-deferred-loading \
  lib/i18n/*.dart \
  lib/i18n/*.arb
```
