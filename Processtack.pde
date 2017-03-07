import java.io.*;

String program = "";
String[]input;

boolean fileArg = false;
boolean inputArg = false;

String programFile = "";
String inputFile = "";


void setup(){
	for (String arg:args) {
		if (fileArg) {
			programFile = arg;
			fileArg = false;
			continue;
		} else if (inputArg) {
			inputFile = arg;
			inputArg = false;
			continue;
		}

		switch (arg) {
			case "-f":
				fileArg = true;
				break;
			case "-i":
				inputArg = true;
				break;
			case "-h":
				printHelp();
				break;
			default:
				println("Argument not recognised: " + arg);
				printHelp();
		}
	}

	if (!programFile.equals("")) {
		program = String.join("\n", loadStrings(programFile));
	} else {
		println("Error: no program file passed");
		printHelp();
	}

	if (!inputFile.equals("")) {
		input = loadStrings(inputFile);
	} else {
		println("Error: no program file passed");
		printHelp();
	}
}

void printHelp() {
	println();
	println("Usage: processing-java --sketch=`pwd` --run [arguments]");
	println();
	println("\t\t-h            displays this help menu");
	println("\t\t-f <filename> runs <filename> as a Processtack program");
	println("\t\t-i <input>    gives <input> (must be a file) as an input to the program");
	exit();
}
/*
void FileNotFound(String filename) {
	println("File not found: " + filename);
	exit();
}*/
