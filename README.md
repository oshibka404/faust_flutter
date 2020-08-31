# faust_flutter
Minimal audio application with Flutter UI and Faust DSP.

## Prerequisites
- Flutter SDK
- Faust SDK

## Build instructions
Build DSP layer:
```sh
$ faust2api -ios -nozip -target ./ios/Runner/DSP ./DSP/main.dsp
```

Start UI:
```sh
$ flutter run
```
