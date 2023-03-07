part of 'settings_cubit.dart';

@immutable
class SettingsState {
  final bool isFahrenheit;

  const SettingsState({
    required this.isFahrenheit,
  });

  
  SettingsState copyWith({
    bool? isFahrenheit,
  }) {
    return SettingsState(
      isFahrenheit: isFahrenheit ?? this.isFahrenheit,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SettingsState &&
      other.isFahrenheit == isFahrenheit;
  }

  @override
  int get hashCode => isFahrenheit.hashCode;
}
