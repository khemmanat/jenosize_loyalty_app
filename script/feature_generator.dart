import 'dart:io';

void main() async {
  print('🚀 Flutter Feature Generator - Clean Architecture');
  print('=' * 50);

  // Get feature name from user
  stdout.write('What feature name: ');
  String? featureName = stdin.readLineSync();

  if (featureName == null || featureName.trim().isEmpty) {
    print('❌ Feature name cannot be empty!');
    exit(1);
  }

  featureName = featureName.trim().toLowerCase();

  try {
    await generateFeatureStructure(featureName);
    print('\n✅ Feature "$featureName" created successfully!');
    print('📁 Check your project directory for the new feature structure.');
  } catch (e) {
    print('❌ Error creating feature: $e');
    exit(1);
  }
}

Future<void> generateFeatureStructure(String featureName) async {
  final String baseDir = featureName;

  // Create directory structure
  await createDirectories(baseDir, featureName);

  // Create default files
  await createDefaultFiles(baseDir, featureName);

  print('\n📂 Created directory structure:');
  await printDirectoryTree(baseDir);
}

Future<void> createDirectories(String baseDir, String featureName) async {
  final directories = [
    '$baseDir',
    '$baseDir/domain',
    '$baseDir/domain/entities',
    '$baseDir/domain/repositories',
    '$baseDir/domain/usecases',
    '$baseDir/data',
    '$baseDir/data/models',
    '$baseDir/data/repositories',
    '$baseDir/data/datasources',
    '$baseDir/data/datasources/remote',
    '$baseDir/data/datasources/local',
    '$baseDir/presentation',
    '$baseDir/presentation/pages',
    '$baseDir/presentation/widgets',
  ];

  for (String dir in directories) {
    await Directory(dir).create(recursive: true);
    print('📁 Created: $dir/');
  }
}

Future<void> createDefaultFiles(String baseDir, String featureName) async {
  // Convert feature name to different cases
  final pascalCase = toPascalCase(featureName);
  final camelCase = toCamelCase(featureName);
  final snakeCase = toSnakeCase(featureName);

  // Create files with content
  await createFileWithContent(
      '$baseDir/domain/entities/${snakeCase}_entity.dart',
      generateEntityContent(pascalCase, featureName)
  );

  await createFileWithContent(
      '$baseDir/domain/repositories/${snakeCase}_repository.dart',
      generateRepositoryInterfaceContent(pascalCase, featureName)
  );

  await createFileWithContent(
      '$baseDir/domain/usecases/get_${snakeCase}_usecase.dart',
      generateUseCaseContent(pascalCase, featureName)
  );

  await createFileWithContent(
      '$baseDir/data/models/${snakeCase}_model.dart',
      generateModelContent(pascalCase, featureName)
  );

  await createFileWithContent(
      '$baseDir/data/repositories/${snakeCase}_repository_impl.dart',
      generateRepositoryImplContent(pascalCase, featureName)
  );

  await createFileWithContent(
      '$baseDir/data/datasources/remote/${snakeCase}_remote_datasource.dart',
      generateRemoteDataSourceContent(pascalCase, featureName)
  );

  await createFileWithContent(
      '$baseDir/data/datasources/local/${snakeCase}_local_datasource.dart',
      generateLocalDataSourceContent(pascalCase, featureName)
  );

  await createFileWithContent(
      '$baseDir/presentation/pages/${snakeCase}_page.dart',
      generatePageContent(pascalCase, featureName)
  );

  await createFileWithContent(
      '$baseDir/presentation/widgets/${snakeCase}_widget.dart',
      generateWidgetContent(pascalCase, featureName)
  );

  print('\n📄 Created files:');
  print('   - ${snakeCase}_entity.dart');
  print('   - ${snakeCase}_repository.dart');
  print('   - get_${snakeCase}_usecase.dart');
  print('   - ${snakeCase}_model.dart');
  print('   - ${snakeCase}_repository_impl.dart');
  print('   - ${snakeCase}_remote_datasource.dart');
  print('   - ${snakeCase}_local_datasource.dart');
  print('   - ${snakeCase}_page.dart');
  print('   - ${snakeCase}_widget.dart');
}

Future<void> createFileWithContent(String filePath, String content) async {
  final file = File(filePath);
  await file.writeAsString(content);
}

// Content generators
String generateEntityContent(String pascalCase, String featureName) {
  return '''class ${pascalCase}Entity {
  final String id;
  final String name;
  // Add more properties as needed
  
  const ${pascalCase}Entity({
    required this.id,
    required this.name,
  });
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ${pascalCase}Entity &&
        other.id == id &&
        other.name == name;
  }
  
  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
''';
}

String generateRepositoryInterfaceContent(String pascalCase, String featureName) {
  return '''import '../entities/${toSnakeCase(featureName)}_entity.dart';

abstract class ${pascalCase}Repository {
  Future<List<${pascalCase}Entity>> getAll${pascalCase}s();
  Future<${pascalCase}Entity?> get${pascalCase}ById(String id);
  Future<void> create${pascalCase}(${pascalCase}Entity ${toCamelCase(featureName)});
  Future<void> update${pascalCase}(${pascalCase}Entity ${toCamelCase(featureName)});
  Future<void> delete${pascalCase}(String id);
}
''';
}

String generateUseCaseContent(String pascalCase, String featureName) {
  return '''import '../entities/${toSnakeCase(featureName)}_entity.dart';
import '../repositories/${toSnakeCase(featureName)}_repository.dart';

class Get${pascalCase}UseCase {
  final ${pascalCase}Repository repository;
  
  Get${pascalCase}UseCase(this.repository);
  
  Future<List<${pascalCase}Entity>> call() async {
    return await repository.getAll${pascalCase}s();
  }
}
''';
}

String generateModelContent(String pascalCase, String featureName) {
  return '''import '../../domain/entities/${toSnakeCase(featureName)}_entity.dart';

class ${pascalCase}Model extends ${pascalCase}Entity {
  const ${pascalCase}Model({
    required super.id,
    required super.name,
  });
  
  factory ${pascalCase}Model.fromJson(Map<String, dynamic> json) {
    return ${pascalCase}Model(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
  
  ${pascalCase}Entity toEntity() {
    return ${pascalCase}Entity(
      id: id,
      name: name,
    );
  }
}
''';
}

String generateRepositoryImplContent(String pascalCase, String featureName) {
  final snakeCase = toSnakeCase(featureName);
  return '''import '../../domain/entities/${snakeCase}_entity.dart';
import '../../domain/repositories/${snakeCase}_repository.dart';
import '../datasources/remote/${snakeCase}_remote_datasource.dart';
import '../datasources/local/${snakeCase}_local_datasource.dart';

class ${pascalCase}RepositoryImpl implements ${pascalCase}Repository {
  final ${pascalCase}RemoteDataSource remoteDataSource;
  final ${pascalCase}LocalDataSource localDataSource;
  
  ${pascalCase}RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  
  @override
  Future<List<${pascalCase}Entity>> getAll${pascalCase}s() async {
    try {
      final remoteData = await remoteDataSource.getAll${pascalCase}s();
      await localDataSource.cacheAll${pascalCase}s(remoteData);
      return remoteData.map((model) => model.toEntity()).toList();
    } catch (e) {
      final localData = await localDataSource.getAll${pascalCase}s();
      return localData.map((model) => model.toEntity()).toList();
    }
  }
  
  @override
  Future<${pascalCase}Entity?> get${pascalCase}ById(String id) async {
    try {
      final model = await remoteDataSource.get${pascalCase}ById(id);
      return model?.toEntity();
    } catch (e) {
      final model = await localDataSource.get${pascalCase}ById(id);
      return model?.toEntity();
    }
  }
  
  @override
  Future<void> create${pascalCase}(${pascalCase}Entity ${toCamelCase(featureName)}) async {
    // Implementation here
  }
  
  @override
  Future<void> update${pascalCase}(${pascalCase}Entity ${toCamelCase(featureName)}) async {
    // Implementation here
  }
  
  @override
  Future<void> delete${pascalCase}(String id) async {
    // Implementation here
  }
}
''';
}

String generateRemoteDataSourceContent(String pascalCase, String featureName) {
  return '''import '../../models/${toSnakeCase(featureName)}_model.dart';

abstract class ${pascalCase}RemoteDataSource {
  Future<List<${pascalCase}Model>> getAll${pascalCase}s();
  Future<${pascalCase}Model?> get${pascalCase}ById(String id);
  Future<void> create${pascalCase}(${pascalCase}Model ${toCamelCase(featureName)});
  Future<void> update${pascalCase}(${pascalCase}Model ${toCamelCase(featureName)});
  Future<void> delete${pascalCase}(String id);
}

class ${pascalCase}RemoteDataSourceImpl implements ${pascalCase}RemoteDataSource {
  // Add HTTP client or any network implementation
  
  @override
  Future<List<${pascalCase}Model>> getAll${pascalCase}s() async {
    // Implementation for API call
    throw UnimplementedError();
  }
  
  @override
  Future<${pascalCase}Model?> get${pascalCase}ById(String id) async {
    // Implementation for API call
    throw UnimplementedError();
  }
  
  @override
  Future<void> create${pascalCase}(${pascalCase}Model ${toCamelCase(featureName)}) async {
    // Implementation for API call
    throw UnimplementedError();
  }
  
  @override
  Future<void> update${pascalCase}(${pascalCase}Model ${toCamelCase(featureName)}) async {
    // Implementation for API call
    throw UnimplementedError();
  }
  
  @override
  Future<void> delete${pascalCase}(String id) async {
    // Implementation for API call
    throw UnimplementedError();
  }
}
''';
}

String generateLocalDataSourceContent(String pascalCase, String featureName) {
  return '''import '../../models/${toSnakeCase(featureName)}_model.dart';

abstract class ${pascalCase}LocalDataSource {
  Future<List<${pascalCase}Model>> getAll${pascalCase}s();
  Future<${pascalCase}Model?> get${pascalCase}ById(String id);
  Future<void> cacheAll${pascalCase}s(List<${pascalCase}Model> ${toCamelCase(featureName)}s);
  Future<void> cache${pascalCase}(${pascalCase}Model ${toCamelCase(featureName)});
  Future<void> delete${pascalCase}(String id);
}

class ${pascalCase}LocalDataSourceImpl implements ${pascalCase}LocalDataSource {
  // Add local storage implementation (SharedPreferences, Hive, etc.)
  
  @override
  Future<List<${pascalCase}Model>> getAll${pascalCase}s() async {
    // Implementation for local storage
    throw UnimplementedError();
  }
  
  @override
  Future<${pascalCase}Model?> get${pascalCase}ById(String id) async {
    // Implementation for local storage
    throw UnimplementedError();
  }
  
  @override
  Future<void> cacheAll${pascalCase}s(List<${pascalCase}Model> ${toCamelCase(featureName)}s) async {
    // Implementation for caching
    throw UnimplementedError();
  }
  
  @override
  Future<void> cache${pascalCase}(${pascalCase}Model ${toCamelCase(featureName)}) async {
    // Implementation for caching
    throw UnimplementedError();
  }
  
  @override
  Future<void> delete${pascalCase}(String id) async {
    // Implementation for deletion
    throw UnimplementedError();
  }
}
''';
}

String generatePageContent(String pascalCase, String featureName) {
  return '''import 'package:flutter/material.dart';

class ${pascalCase}Page extends StatefulWidget {
  const ${pascalCase}Page({super.key});
  
  @override
  State<${pascalCase}Page> createState() => _${pascalCase}PageState();
}

class _${pascalCase}PageState extends State<${pascalCase}Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${pascalCase}'),
      ),
      body: const Center(
        child: Text(
          '${pascalCase} Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
''';
}

String generateWidgetContent(String pascalCase, String featureName) {
  return '''import 'package:flutter/material.dart';

class ${pascalCase}Widget extends StatelessWidget {
  const ${pascalCase}Widget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            '${pascalCase} Widget',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          // Add your widget content here
        ],
      ),
    );
  }
}
''';
}

// Utility functions for string manipulation
String toPascalCase(String input) {
  return input
      .split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
      .join('');
}

String toCamelCase(String input) {
  final pascalCase = toPascalCase(input);
  return pascalCase[0].toLowerCase() + pascalCase.substring(1);
}

String toSnakeCase(String input) {
  return input
      .replaceAllMapped(RegExp(r'([A-Z])'), (match) => '_${match.group(1)!.toLowerCase()}')
      .replaceAll(RegExp(r'^_'), '')
      .toLowerCase();
}

Future<void> printDirectoryTree(String rootDir) async {
  await _printTree(Directory(rootDir), '', true);
}

Future<void> _printTree(Directory dir, String prefix, bool isLast) async {
  final dirName = dir.path.split('/').last;
  print('$prefix${isLast ? '└── ' : '├── '}$dirName/');

  final entities = await dir.list().toList();
  entities.sort((a, b) {
    if (a is Directory && b is File) return -1;
    if (a is File && b is Directory) return 1;
    return a.path.compareTo(b.path);
  });

  for (int i = 0; i < entities.length; i++) {
    final entity = entities[i];
    final isLastEntity = i == entities.length - 1;
    final newPrefix = prefix + (isLast ? '    ' : '│   ');

    if (entity is Directory) {
      await _printTree(entity, newPrefix, isLastEntity);
    } else {
      final fileName = entity.path.split('/').last;
      print('$newPrefix${isLastEntity ? '└── ' : '├── '}$fileName');
    }
  }
}