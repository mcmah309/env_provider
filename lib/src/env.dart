import 'dart:io';

import 'package:rust_core/rust_core.dart';

class Env {
  /// Returns the current working directory as a Path.
  static String currentDirectory() => Directory.current.path;

  /// The path of the executable used to run the script in this isolate.
  /// Usually `dart` when running on the Dart VM or the
  /// compiled script name (`script_name.exe`).
  ///
  /// The literal path used to identify the executable.
  /// This path might be relative or just be a name from which the executable
  /// was found by searching the system path.
  ///
  /// Use [resolvedExecutable] to get an absolute path to the executable.
  static String currentExe() => Platform.executable;

  /// Joins a collection of Paths appropriately for the PATH environment variable.
  static String joinPaths(Iterable<String> paths) => paths.join(":");

  /// Get the value of an environment variable.
  static Result<String, EnvVarNotPresent> variable(String envVar) {
    final val = Platform.environment[envVar];
    if (val == null) {
      return Err(EnvVarNotPresent(envVar));
    }
    return Ok(val);
  }

  /// Returns an iterator of (variable, value) pairs of strings, for all the environment variables of the current process.
  static Iterable<(String, String)> variables() =>
      Platform.environment.entries.map((entry) => (entry.key, entry.value));

  static void setCurrentDirectory(String currentDirectory) => Directory.current = currentDirectory;

  
}

/// Error type for when an environment variable is not present.
final class EnvVarNotPresent {
  final String envVar;

  EnvVarNotPresent(this.envVar);

  @override
  String toString() {
    return "Variable $envVar is not present in the environment.";
  }
}
