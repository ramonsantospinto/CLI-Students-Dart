import 'package:args/command_runner.dart';
import 'package:cli_treino/src/commands/students/students_command.dart';

void main(List<String> arguments) {
  CommandRunner('CLI', 'CLI Students')
    ..addCommand(StudentsCommand())
    ..run(arguments);
}
