/// Optionaler LLM-Backend-Hinweis. Standard: aus (offline).
///
/// Aktivierung nur mit explizitem Dart-Define, z. B.:
/// `flutter run -d chrome --dart-define=UITRAINING_LLM_ENDPOINT=https://…`
/// und optional `UITRAINING_LLM_API_KEY=…`.
///
/// Ohne Endpoint wird nie Netzwerk genutzt. Secrets gehören nicht ins Repo.
class OptionalLlmConfig {
  const OptionalLlmConfig._({
    required this.endpoint,
    required this.apiKey,
  });

  factory OptionalLlmConfig.fromEnvironment() {
    const endpoint = String.fromEnvironment('UITRAINING_LLM_ENDPOINT');
    const apiKey = String.fromEnvironment('UITRAINING_LLM_API_KEY');
    return OptionalLlmConfig._(
      endpoint: endpoint.trim(),
      apiKey: apiKey.trim(),
    );
  }

  final String endpoint;
  final String apiKey;

  bool get isConfigured => endpoint.isNotEmpty;

  /// Bewusst nicht implementierter Netzwerk-Call: Demo bleibt offline-first.
  /// Wenn konfiguriert, signalisiert die UI nur, dass LLM optional wäre.
  String statusMessageDe() {
    if (!isConfigured) {
      return 'Offline-Modus: Antworten kommen aus den Playground-Docs '
          '(kein Netzwerk).';
    }
    return 'LLM-Endpoint ist gesetzt (`UITRAINING_LLM_ENDPOINT`), '
        'dieser Build nutzt ihn bewusst nicht für Auto-Calls — '
        'Standard bleibt der Offline-Knowledge-Chat. '
        'API-Keys werden nie geloggt oder ins Repo geschrieben.';
  }
}
