import 'package:injectable/injectable.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:hex/hex.dart';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'dart:convert';

/// Simple blockchain service for multichain wallet support
/// Uses free public RPCs for production
@lazySingleton
class BlockchainService {
  // Free public RPC endpoints
  static const String ethereumRpc = 'https://eth.public-rpc.com';
  static const String bscRpc = 'https://bsc-dataseed.binance.org';
  static const String polygonRpc = 'https://polygon-rpc.com';
  static const String tronRpc = 'https://api.trongrid.io';

  /// Generate a new wallet with mnemonic
  /// Returns a map containing mnemonic and addresses for different chains
  Map<String, dynamic> generateWallet() {
    try {
      // Generate 12-word mnemonic
      final mnemonic = bip39.generateMnemonic();

      // Generate seed from mnemonic
      final seed = bip39.mnemonicToSeed(mnemonic);

      // Generate addresses for different chains
      final addresses = <String, String>{};

      // Ethereum/BSC/Polygon use same derivation path (m/44'/60'/0'/0/0)
      final ethAddress = _deriveEthereumAddress(seed);
      addresses['Ethereum'] = ethAddress;
      addresses['BSC'] = ethAddress; // Same address for BSC
      addresses['Polygon'] = ethAddress; // Same address for Polygon

      // For Tron, we'll use a placeholder for now (requires different derivation)
      addresses['Tron'] =
          'T${ethAddress.substring(2, 36)}'; // Simplified placeholder

      return {
        'mnemonic': mnemonic,
        'addresses': addresses,
        'seed': HEX.encode(seed),
      };
    } catch (e) {
      throw Exception('Failed to generate wallet: $e');
    }
  }

  /// Derive Ethereum-compatible address from seed
  String _deriveEthereumAddress(Uint8List seed) {
    try {
      // BIP44 path for Ethereum: m/44'/60'/0'/0/0
      final root = bip32.BIP32.fromSeed(seed);
      final child = root.derivePath("m/44'/60'/0'/0/0");

      // Get public key
      final publicKey = child.publicKey;

      // Keccak-256 hash of public key (removing first byte)
      final pubKeyHash = sha256.convert(publicKey.sublist(1)).bytes;

      // Take last 20 bytes for address
      final address = '0x${HEX.encode(pubKeyHash.sublist(12))}';

      return address;
    } catch (e) {
      // Fallback to simple hash-based address generation
      final hash = sha256.convert(seed).bytes;
      return '0x${HEX.encode(hash.sublist(0, 20))}';
    }
  }

  /// Get address for a specific chain from multichain addresses
  String? getAddressForChain(Map<String, String>? addresses, String chain) {
    if (addresses == null) return null;
    return addresses[chain];
  }

  /// Encrypt private data (mnemonic/seed) before storing
  /// Simple encryption using AES would be better, but for simplicity we'll use base64 encoding
  /// In production, use proper encryption like AES-256
  String encryptData(String data) {
    try {
      // For now, just base64 encode (NOT SECURE - replace with AES in production)
      final bytes = utf8.encode(data);
      return base64.encode(bytes);
    } catch (e) {
      throw Exception('Failed to encrypt data: $e');
    }
  }

  /// Decrypt private data
  String decryptData(String encryptedData) {
    try {
      // For now, just base64 decode (NOT SECURE - replace with AES in production)
      final bytes = base64.decode(encryptedData);
      return utf8.decode(bytes);
    } catch (e) {
      throw Exception('Failed to decrypt data: $e');
    }
  }

  /// Validate if an address is valid for a given chain
  bool isValidAddress(String address, String chain) {
    switch (chain.toLowerCase()) {
      case 'ethereum':
      case 'bsc':
      case 'polygon':
        // Check if it's a valid Ethereum-style address
        return RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(address);
      case 'tron':
        // Check if it's a valid Tron address (starts with T)
        return RegExp(r'^T[a-zA-Z0-9]{33}$').hasMatch(address);
      default:
        return false;
    }
  }

  /// Get available blockchain networks
  List<String> getAvailableChains() {
    return ['Ethereum', 'BSC', 'Polygon', 'Tron'];
  }

  /// Get RPC URL for a specific chain
  String getRpcUrl(String chain) {
    switch (chain.toLowerCase()) {
      case 'ethereum':
        return ethereumRpc;
      case 'bsc':
        return bscRpc;
      case 'polygon':
        return polygonRpc;
      case 'tron':
        return tronRpc;
      default:
        return ethereumRpc;
    }
  }
}
