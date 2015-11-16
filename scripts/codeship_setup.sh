#! /bin/bash
wget http://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-x64-release.zip
unzip -o dartsdk-linux-x64-release.zip -d ~
~/dart-sdk/bin/pub get

cat > test/config/config.dart <<EOF
abstract class Config {
  static final loginId = '${LOGIN_ID}';
  static final apiKey = '${API_KEY}';
}
EOF

