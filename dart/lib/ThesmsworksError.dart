class ThesmsworksError extends Error {
  final bool isThesmsworksError = true;

  final String sdk = 'Thesmsworks';

  String code;
  String message;
  dynamic ctx;

  // Populated by makeError with the (cleaned) result and spec.
  dynamic result;
  dynamic spec;

  ThesmsworksError(this.code, this.message, [this.ctx]);

  @override
  String toString() => 'ThesmsworksError: ' + code + ': ' + message;
}
