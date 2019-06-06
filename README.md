# fake_lifecycle

[![Build Status](https://cloud.drone.io/api/badges/v7lin/fake_lifecycle/status.svg)](https://cloud.drone.io/v7lin/fake_lifecycle)
[![Codecov](https://codecov.io/gh/v7lin/fake_lifecycle/branch/master/graph/badge.svg)](https://codecov.io/gh/v7lin/fake_lifecycle)
[![GitHub Tag](https://img.shields.io/github/tag/v7lin/fake_lifecycle.svg)](https://github.com/v7lin/fake_lifecycle/releases)
[![Pub Package](https://img.shields.io/pub/v/fake_lifecycle.svg)](https://pub.dartlang.org/packages/fake_lifecycle)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://github.com/v7lin/fake_lifecycle/blob/master/LICENSE)

A powerful package for Flutter.

## flutter

* 重点

````
# 请勿使用 Navigator 的以下几种方式路由
pushAndRemoveUntil
pushNamedAndRemoveUntil
removeRoute
removeRouteBelow
`````

* snapshot

````
dependencies:
  fake_lifecycle:
    git:
      url: https://github.com/v7lin/fake_lifecycle.git
````

* release

````
dependencies:
  fake_lifecycle: ^${latestTag}
````

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
