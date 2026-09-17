# Kryptografi

A [Flutter](https://flutter.dev) plugin that provides RSA encryption, decryption, signing and verification for Android and iOS.

RSA operations are implemented natively on each platform — **Kotlin** (Android, via `java.security` and `javax.crypto`) and **Swift / Objective-C** (iOS, via the Security framework) — and exposed to Dart through a single [method channel](https://docs.flutter.dev/platform-integration/platform-channels).

## Platforms

| Platform | Language | Implementation |
|----------|----------|----------------|
| Android  | Kotlin   | `java.security` + `javax.crypto.Cipher` |
| iOS      | Swift / Objective-C | Security framework |

## Available operations

The following top-level Dart functions are exposed from `package:kryptografi/kryptografi.dart`:

| Function | Description |
|----------|-------------|
| `encryptBase64(txt, publicKey)` | Encrypt a string with a public key and return a Base64 result |
| `encryptUTF8(txt, publicKey)` | Encrypt a string with a public key and return a UTF-8 result |
| `decrypt(txt, privateKey)` | Decrypt a string with a private key |
| `sign(plainText, privateKey)` | Sign a string with a private key |
| `verify(plainText, signature, publicKey)` | Verify a signature against the plaintext with a public key |
| `decryptUsingPublicKey(plainText, publicKey)` | Decrypt a string using a public key |

Keys are supplied as PEM strings. The PEM header/footer (`-----BEGIN PUBLIC KEY-----`, `-----BEGIN PRIVATE KEY-----`, `-----BEGIN RSA PRIVATE KEY-----`, etc.) is stripped automatically before being passed to the native layer.

## Usage

```dart
import 'package:kryptografi/kryptografi.dart';

Future<void> main() async {
  const publicKey = '''-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA...
-----END PUBLIC KEY-----''';

  const privateKey = '''-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEA...
-----END PRIVATE KEY-----''';

  final encrypted = await encryptBase64('secret message', publicKey);
  final decrypted = await decrypt(encrypted, privateKey);

  final signature = await sign('secret message', privateKey);
  final isValid = await verify('secret message', signature, publicKey);
}
```

An example Flutter application is included in [`example/`](example).

## Installation

Add the package as a git dependency in `pubspec.yaml`:

```yaml
dependencies:
  kryptografi:
    git:
      url: https://github.com/chinmay-tayade/Kryptografi.git
```

## Project structure

```
lib/                     # Dart side of the plugin (public API + method channel)
android/                 # Android (Kotlin) native implementation
ios/                     # iOS (Swift/Objective-C) native implementation
example/                 # Example Flutter app
test/                    # Dart unit tests
```

## License

MIT — see [LICENSE](LICENSE).
