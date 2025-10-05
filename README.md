# Kryptografi

<div align="center">

![iOS](https://img.shields.io/badge/Platform-iOS-000000?style=for-the-badge&logo=apple&logoColor=white)
![Swift](https://img.shields.io/badge/Swift-5.9-FA7343?style=for-the-badge&logo=swift&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

**A native Swift library for RSA encryption and decryption**

[Report Bug](../../issues) • [Request Feature](../../issues)

</div>

---

## About

Kryptografi is a lightweight, native Swift library that provides easy-to-use RSA encryption and decryption capabilities for iOS and macOS applications. Built entirely using Apple's Security framework, it offers a modern Swift API for cryptographic operations without relying on external dependencies.

### Key Features

- **Pure Swift** implementation using native Security framework
- **RSA Encryption/Decryption** with multiple key sizes
- **Zero Dependencies** - uses only Apple's native frameworks
- **Type-Safe API** with Swift best practices
- **iOS & macOS** compatible
- **Keychain Integration** for secure key storage

---

## Features

### Cryptographic Operations
- RSA key pair generation (1024, 2048, 4096 bit)
- Public key encryption
- Private key decryption
- Sign data with private key
- Verify signatures with public key
- Support for PKCS1 and OAEP padding

### Key Management
- Generate new RSA key pairs
- Import existing keys (PEM, DER formats)
- Export public/private keys
- Secure storage in iOS Keychain
- Key persistence and retrieval
- Delete keys from Keychain

### Security Features
- Secure enclave support (where available)
- Hardware-backed cryptography
- Biometric authentication integration
- Secure random number generation
- Memory-safe operations
- Automatic key cleanup

### Developer Experience
- Simple, intuitive Swift API
- Comprehensive error handling
- Detailed documentation
- Example projects included
- Swift Package Manager support
- CocoaPods compatible

---

## Tech Stack

### Core Technologies
- **Language:** Swift 5.9+
- **Platform:** iOS 13.0+, macOS 10.15+
- **Framework:** Security.framework
- **Package Management:** Swift Package Manager, CocoaPods

### Apple Frameworks
- **Security** - Core cryptographic operations
- **CommonCrypto** - Additional crypto utilities
- **Foundation** - Base data types and utilities
- **LocalAuthentication** - Biometric authentication

### Architecture
- **Protocol-Oriented** design
- **Error Handling** with Swift Result type
- **Value Types** for better performance
- **Generic Programming** for flexibility

---

## Installation

### Swift Package Manager

Add Kryptografi to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Chinmay-tayade/Kryptografi.git", from: "1.0.0")
]
```

Or in Xcode:
1. File > Add Packages...
2. Enter: `https://github.com/Chinmay-tayade/Kryptografi`
3. Click Add Package

### CocoaPods

Add to your `Podfile`:

```ruby
pod 'Kryptografi', '~> 1.0'
```

Then run:
```bash
pod install
```

### Manual Installation

1. Download the latest release
2. Drag `Kryptografi.swift` into your Xcode project
3. Ensure it's added to your target

---

## Quick Start

### Basic Encryption/Decryption

```swift
import Kryptografi

// Generate RSA key pair
let keyPair = try RSAKeyPair.generate(keySize: 2048)

// Encrypt data
let plainText = "Hello, World!"
let encryptedData = try keyPair.publicKey.encrypt(string: plainText)

// Decrypt data
let decryptedData = try keyPair.privateKey.decrypt(data: encryptedData)
let decryptedText = String(data: decryptedData, encoding: .utf8)
```

### Store Keys in Keychain

```swift
// Save key pair to Keychain
try keyPair.saveToKeychain(tag: "com.myapp.keys")

// Retrieve from Keychain later
if let retrievedKeyPair = try RSAKeyPair.loadFromKeychain(tag: "com.myapp.keys") {
    // Use the key pair
}

// Delete from Keychain
try RSAKeyPair.deleteFromKeychain(tag: "com.myapp.keys")
```

### Signing and Verification

```swift
// Sign data
let dataToSign = "Important message".data(using: .utf8)!
let signature = try keyPair.privateKey.sign(data: dataToSign)

// Verify signature
let isValid = try keyPair.publicKey.verify(
    signature: signature,
    for: dataToSign
)
print("Signature is valid: \(isValid)")
```

### Import/Export Keys

```swift
// Export public key as PEM
let publicKeyPEM = try keyPair.publicKey.exportPEM()

// Export private key as DER
let privateKeyDER = try keyPair.privateKey.exportDER()

// Import public key from PEM
let importedPublicKey = try RSAPublicKey.importPEM(publicKeyPEM)

// Import private key from DER
let importedPrivateKey = try RSAPrivateKey.importDER(privateKeyDER)
```

---

## API Documentation

### RSAKeyPair

Main class for RSA key pair operations.

```swift
class RSAKeyPair {
    /// Generate a new RSA key pair
    static func generate(keySize: KeySize) throws -> RSAKeyPair
    
    /// The public key component
    var publicKey: RSAPublicKey { get }
    
    /// The private key component
    var privateKey: RSAPrivateKey { get }
    
    /// Save to iOS Keychain
    func saveToKeychain(tag: String) throws
    
    /// Load from Keychain
    static func loadFromKeychain(tag: String) throws -> RSAKeyPair?
    
    /// Delete from Keychain
    static func deleteFromKeychain(tag: String) throws
}
```

### RSAPublicKey

Operations with public key.

```swift
class RSAPublicKey {
    /// Encrypt data
    func encrypt(data: Data) throws -> Data
    
    /// Encrypt string
    func encrypt(string: String) throws -> Data
    
    /// Verify signature
    func verify(signature: Data, for data: Data) throws -> Bool
    
    /// Export as PEM format
    func exportPEM() throws -> String
    
    /// Export as DER format
    func exportDER() throws -> Data
    
    /// Import from PEM
    static func importPEM(_ pem: String) throws -> RSAPublicKey
}
```

### RSAPrivateKey

Operations with private key.

```swift
class RSAPrivateKey {
    /// Decrypt data
    func decrypt(data: Data) throws -> Data
    
    /// Sign data
    func sign(data: Data) throws -> Data
    
    /// Export as PEM format
    func exportPEM() throws -> String
    
    /// Export as DER format
    func exportDER() throws -> Data
    
    /// Import from PEM
    static func importPEM(_ pem: String) throws -> RSAPrivateKey
}
```

### Error Handling

```swift
enum KryptografiError: Error {
    case keyGenerationFailed
    case encryptionFailed
    case decryptionFailed
    case invalidKey
    case keychainError(OSStatus)
    case invalidData
    case signingFailed
    case verificationFailed
}
```

---

## Advanced Usage

### Secure Enclave Integration

```swift
// Generate key with Secure Enclave (iOS devices with A7+ chip)
let secureKeyPair = try RSAKeyPair.generate(
    keySize: .bits2048,
    useSecureEnclave: true
)
```

### Biometric Authentication

```swift
// Require biometric authentication for key access
let protectedKeyPair = try RSAKeyPair.generate(
    keySize: .bits2048,
    requireBiometrics: true
)

// Accessing the key will prompt Face ID/Touch ID
let encrypted = try protectedKeyPair.publicKey.encrypt(string: "Secret")
```

### Custom Padding

```swift
// Use OAEP padding instead of PKCS1
let encrypted = try publicKey.encrypt(
    data: plainData,
    padding: .OAEP
)
```

---

## Architecture

The library is organized into several components:

```
Kryptografi/
├── Core/
│   ├── RSAKeyPair.swift       # Main key pair class
│   ├── RSAPublicKey.swift     # Public key operations
│   └── RSAPrivateKey.swift    # Private key operations
│
├── KeyManagement/
│   ├── KeychainHelper.swift   # Keychain operations
│   ├── KeyImporter.swift      # Import keys
│   └── KeyExporter.swift      # Export keys
│
├── Utilities/
│   ├── SecurityUtils.swift    # Security helpers
│   ├── DataExtensions.swift   # Data conversion
│   └── ErrorHandling.swift    # Error definitions
│
└── Tests/
    ├── EncryptionTests.swift
    ├── KeyManagementTests.swift
    └── SignatureTests.swift
```

---

## Testing

The library includes comprehensive unit tests.

### Run Tests

```bash
# Using Swift Package Manager
swift test

# In Xcode
Cmd + U
```

### Test Coverage

- Encryption/Decryption tests
- Key generation tests
- Keychain integration tests
- Signature verification tests
- Import/Export tests
- Error handling tests

---

## Security Considerations

### Best Practices

1. **Key Size**: Use at least 2048-bit keys for production
2. **Key Storage**: Always store private keys in Keychain
3. **Secure Enclave**: Use when available for maximum security
4. **Key Rotation**: Implement regular key rotation
5. **Error Handling**: Never expose sensitive data in error messages

### Known Limitations

- RSA is not suitable for encrypting large data (use hybrid encryption)
- Key generation can be slow on older devices
- Secure Enclave available only on certain devices

---

## Performance

### Benchmarks (iPhone 14 Pro)

| Operation | Key Size | Time |
|-----------|----------|------|
| Key Generation | 2048-bit | ~150ms |
| Encryption | 2048-bit | ~5ms |
| Decryption | 2048-bit | ~15ms |
| Signing | 2048-bit | ~10ms |
| Verification | 2048-bit | ~5ms |

---

## Examples

Check the `Examples/` directory for complete sample projects:

- **BasicEncryption** - Simple encryption/decryption
- **KeychainIntegration** - Secure key storage
- **SignatureVerification** - Digital signatures
- **SecureMessaging** - End-to-end encrypted chat

---

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

### Development Setup

```bash
git clone https://github.com/Chinmay-tayade/Kryptografi.git
cd Kryptografi
swift build
swift test
```

---

## Roadmap

- [ ] AES hybrid encryption support
- [ ] Elliptic Curve Cryptography (ECC)
- [ ] Certificate management
- [ ] watchOS and tvOS support
- [ ] Linux compatibility
- [ ] Performance optimizations
- [ ] Comprehensive documentation site

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Author

**Chinmay Tayade**

- GitHub: [@Chinmay-tayade](https://github.com/Chinmay-tayade)
- LinkedIn: [chinmaytayade](https://linkedin.com/in/chinmaytayade)
- Email: chinmaytayade@outlook.com

---

## Acknowledgments

- Apple Security framework documentation
- Swift Crypto community
- Open-source cryptography projects
- Security researchers and contributors

---

<div align="center">

**Built with Swift and Security.framework**

Made by Chinmay Tayade

</div>
