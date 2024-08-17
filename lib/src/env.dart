import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:rust_core/rust_core.dart';

/// Inspection and manipulation of the process’s environment.
///
/// This module contains functions to inspect various aspects such as environment variables, the current directory, and various other important directories.
class Env {
  /// Returns the current working directory as a Path.
  @pragma('vm:prefer-inline')
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
  @pragma('vm:prefer-inline')
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
  @pragma('vm:prefer-inline')
  static Iterable<(String, String)> variables() =>
      Platform.environment.entries.map((entry) => (entry.key, entry.value));

  @pragma('vm:prefer-inline')
  static void setCurrentDirectory(String currentDirectory) => Directory.current = currentDirectory;

  //************************************************************************//

  /// Path to a directory where the application may place application-specific cache files.
  @pragma('vm:prefer-inline')
  static Future<Directory> getApplicationCacheDirectory() => getApplicationCacheDirectory();

  /// Path to a directory where the application may place data that is user-generated, or that cannot otherwise be recreated by your application.
  @pragma('vm:prefer-inline')
  static Future<Directory> getApplicationDocumentsDirectory() => getApplicationDocumentsDirectory();

  /// Path to a directory where the application may place application support files.
  @pragma('vm:prefer-inline')
  static Future<Directory> getApplicationSupportDirectory() => getApplicationSupportDirectory();

  /// Path to the directory where downloaded files can be stored.
  @pragma('vm:prefer-inline')
  static Future<Directory?> getDownloadsDirectory() => getApplicationSupportDirectory();

  /// Paths to directories where application specific cache data can be stored externally.
  @pragma('vm:prefer-inline')
  static Future<List<Directory>?> getExternalCacheDirectories() => getExternalCacheDirectories();

  /// Paths to directories where application specific data can be stored externally.
  @pragma('vm:prefer-inline')
  static Future<List<Directory>?> getExternalStorageDirectories({StorageDirectory? type}) => getExternalStorageDirectories(type: type);

  /// Path to a directory where the application may access top level storage.
  @pragma('vm:prefer-inline')
  static Future<Directory?> getExternalStorageDirectory() => getExternalStorageDirectory();

  /// Path to the directory where application can store files that are persistent, backed up, and not visible to the user, such as sqlite.db.
  @pragma('vm:prefer-inline')
  static Future<Directory> getLibraryDirectory() => getLibraryDirectory();

  /// Path to the temporary directory on the device that is not backed up and is suitable for storing caches of downloaded files.
  @pragma('vm:prefer-inline')
  static Future<Directory> getTemporaryDirectory() => getTemporaryDirectory();

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
