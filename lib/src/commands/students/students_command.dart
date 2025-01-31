import 'package:args/command_runner.dart';
import '../../repositories/students_repository.dart';
import 'subcommands/delete_command.dart';
import 'subcommands/find_all_commands.dart';
import 'subcommands/find_by_id_command.dart';
import 'subcommands/insert_command.dart';
import 'subcommands/update_command.dart';

class StudentsCommand extends Command {
  @override
  String get description => 'Students Operations';

  @override
  String get name => 'students';

  StudentsCommand() {
    final studentsRepository = StudentsDioRepository();
    addSubcommand(FindAllCommands(studentsRepository));
    addSubcommand(FindByIdCommand(studentsRepository));
    addSubcommand(InsertCommand(studentsRepository));
    addSubcommand(UpdateCommand(studentsRepository));
    addSubcommand(DeleteCommand(studentsRepository));
  }
}
