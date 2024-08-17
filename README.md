# Env Provider

Env Provider is an all in one utility for interacting with the environment and will never throw and exception.

## Usage

### Platform Directories
Env Provider is safe super-set of [path_provider](https://pub.dev/packages/path_provider). As such, all
methods of path_provider can be accessed from `Env`. e.g
```dart
Result<Directory, DirectoryRetrievalError> docsDir = await Env.getApplicationDocumentsDirectory();
```

### Get Current Directory

```dart
String currentDir = Env.currentDirectory();
```

### Get the Executable Path

```dart
String exePath = Env.currentExe();
```

### Get an Environment Variable

```dart
String? variable = Env.variable('HOME');
```

### Join Paths

```dart
String path = Env.joinPaths(['/usr/local/bin', '/usr/bin', '/bin']);
print(path); // '/usr/local/bin:/usr/bin:/bin'
```

### List All Environment Variables

```dart
for (var (variable, value) in Env.variables()) {
  print('$variable: $value');
}
```