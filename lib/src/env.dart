import 'dart:io';

import 'package:path_provider/path_provider.dart' as path_provider;
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
  static Future<Result<Directory, DirectoryRetrievalError>> getApplicationCacheDirectory() async {
    try {
      return Ok(await path_provider.getApplicationCacheDirectory());
    } on path_provider.MissingPlatformDirectoryException catch (e) {
      return Err(MissingPlatformDirectory(e));
    } on UnsupportedError catch (e) {
      return Err(Unsupported(e));
    } catch (e) {
      return Err(Unknown(e));
    }
  }

  /// Path to a directory where the application may place data that is user-generated, or that cannot otherwise be recreated by your application.
  static Future<Result<Directory, DirectoryRetrievalError>> getApplicationDocumentsDirectory() async {
    try {
      return Ok(await path_provider.getApplicationDocumentsDirectory());
    } on path_provider.MissingPlatformDirectoryException catch (e) {
      return Err(MissingPlatformDirectory(e));
    } on UnsupportedError catch (e) {
      return Err(Unsupported(e));
    } catch (e) {
      return Err(Unknown(e));
    }
  }

  /// Path to a directory where the application may place application support files.
  static Future<Result<Directory, DirectoryRetrievalError>> getApplicationSupportDirectory() async {
    try {
      return Ok(await path_provider.getApplicationSupportDirectory());
    } on path_provider.MissingPlatformDirectoryException catch (e) {
      return Err(MissingPlatformDirectory(e));
    } on UnsupportedError catch (e) {
      return Err(Unsupported(e));
    } catch (e) {
      return Err(Unknown(e));
    }
  }

  /// Path to the directory where downloaded files can be stored.
  static Future<Result<Directory, DirectoryRetrievalError>> getDownloadsDirectory() async {
    try {
      final directory = await path_provider.getDownloadsDirectory();
      if (directory == null) {
        return const Err(Unknown(DirectoryRetrievalResultInvalid()));
      }
      return Ok(directory);
    } on path_provider.MissingPlatformDirectoryException catch (e) {
      return Err(MissingPlatformDirectory(e));
    } on UnsupportedError catch (e) {
      return Err(Unsupported(e));
    } catch (e) {
      return Err(Unknown(e));
    }
  }

  /// Paths to directories where application specific cache data can be stored externally.
  static Future<Result<List<Directory>?, DirectoryRetrievalError>> getExternalCacheDirectories() async {
    try {
      final directory = await path_provider.getExternalCacheDirectories();
      if (directory == null) {
        return const Err(Unknown(DirectoryRetrievalResultInvalid()));
      }
      return Ok(directory);
    } on path_provider.MissingPlatformDirectoryException catch (e) {
      return Err(MissingPlatformDirectory(e));
    } on UnsupportedError catch (e) {
      return Err(Unsupported(e));
    } catch (e) {
      return Err(Unknown(e));
    }
  }

  /// Paths to directories where application specific data can be stored externally.
  static Future<Result<List<Directory>?, DirectoryRetrievalError>> getExternalStorageDirectories(
      {path_provider.StorageDirectory? type}) async {
    try {
      final directory = await path_provider.getExternalStorageDirectories(type: type);
      if (directory == null) {
        return const Err(Unknown(DirectoryRetrievalResultInvalid()));
      }
      return Ok(directory);
    } on path_provider.MissingPlatformDirectoryException catch (e) {
      return Err(MissingPlatformDirectory(e));
    } on UnsupportedError catch (e) {
      return Err(Unsupported(e));
    } catch (e) {
      return Err(Unknown(e));
    }
  }

  /// Path to a directory where the application may access top level storage.
  static Future<Result<Directory, DirectoryRetrievalError>> getExternalStorageDirectory() async {
    try {
      final directory = await path_provider.getExternalStorageDirectory();
      if (directory == null) {
        return const Err(Unknown(DirectoryRetrievalResultInvalid()));
      }
      return Ok(directory);
    } on path_provider.MissingPlatformDirectoryException catch (e) {
      return Err(MissingPlatformDirectory(e));
    } on UnsupportedError catch (e) {
      return Err(Unsupported(e));
    } catch (e) {
      return Err(Unknown(e));
    }
  }

  /// Path to the directory where application can store files that are persistent, backed up, and not visible to the user, such as sqlite.db.
  static Future<Result<Directory, DirectoryRetrievalError>> getLibraryDirectory() async {
    try {
      return Ok(await path_provider.getLibraryDirectory());
    } on path_provider.MissingPlatformDirectoryException catch (e) {
      return Err(MissingPlatformDirectory(e));
    } on UnsupportedError catch (e) {
      return Err(Unsupported(e));
    } catch (e) {
      return Err(Unknown(e));
    }
  }

  /// Path to the temporary directory on the device that is not backed up and is suitable for storing caches of downloaded files.
  static Future<Result<Directory, DirectoryRetrievalError>> getTemporaryDirectory() async {
    try {
      return Ok(await path_provider.getTemporaryDirectory());
    } on path_provider.MissingPlatformDirectoryException catch (e) {
      return Err(MissingPlatformDirectory(e));
    } on UnsupportedError catch (e) {
      return Err(Unsupported(e));
    } catch (e) {
      return Err(Unknown(e));
    }
  }
}

//************************************************************************//

/// Error type for when an environment variable is not present.
final class EnvVarNotPresent {
  final String envVar;

  EnvVarNotPresent(this.envVar);

  @override
  String toString() {
    return "Variable $envVar is not present in the environment.";
  }
}

sealed class DirectoryRetrievalError {}

final class MissingPlatformDirectory implements DirectoryRetrievalError {
  final path_provider.MissingPlatformDirectoryException inner;

  const MissingPlatformDirectory(this.inner);

  @override
  int get hashCode => inner.hashCode;

  @override
  bool operator ==(Object other) {
    return other is MissingPlatformDirectory && other.inner == inner;
  }

  @override
  String toString() {
    return inner.toString();
  }
}

final class Unsupported implements DirectoryRetrievalError {
  final UnsupportedError inner;

  const Unsupported(this.inner);

  @override
  int get hashCode => inner.hashCode;

  @override
  bool operator ==(Object other) {
    return other is Unsupported && other.inner == inner;
  }

  @override
  String toString() {
    return inner.toString();
  }
}

final class Unknown implements DirectoryRetrievalError {
  final Object inner;

  const Unknown(this.inner);

  @override
  int get hashCode => inner.hashCode;

  @override
  bool operator ==(Object other) {
    return other is Unknown && other.inner == inner;
  }

  @override
  String toString() {
    return inner.toString();
  }
}

//************************************************************************//

/// Usually caused by directory retrieval returning
class DirectoryRetrievalResultInvalid {
  const DirectoryRetrievalResultInvalid();
}
