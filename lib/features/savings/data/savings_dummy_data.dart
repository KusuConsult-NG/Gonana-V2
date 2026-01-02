class SavingsAsset {
  final String name;
  final String icon; // We'll use emojis or assets later
  final double apy;
  final String minDuration;
  final String description;

  const SavingsAsset({
    required this.name,
    required this.icon,
    required this.apy,
    required this.minDuration,
    required this.description,
  });
}

final List<SavingsAsset> mockSavingsAssets = [
  const SavingsAsset(
    name: 'Rice Farm',
    icon: '🌾',
    apy: 12.5,
    minDuration: '6 Months',
    description: 'Invest in premium parboiled rice production.',
  ),
  const SavingsAsset(
    name: 'Maize Silo',
    icon: '🌽',
    apy: 10.0,
    minDuration: '3 Months',
    description: 'Secure storage and trading of yellow maize.',
  ),
  const SavingsAsset(
    name: 'Palm Oil',
    icon: '🛢️',
    apy: 15.0,
    minDuration: '9 Months',
    description: 'High-yield palm oil processing and export.',
  ),
  const SavingsAsset(
    name: 'Cassava',
    icon: '🍠',
    apy: 11.0,
    minDuration: '4 Months',
    description: 'Cassava starch and flour production.',
  ),
  const SavingsAsset(
    name: 'Poultry',
    icon: '🐔',
    apy: 18.0,
    minDuration: '12 Months',
    description: 'Large scale poultry farming and egg production.',
  ),
];
