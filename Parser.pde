class Parser {
	private String program;
	private ArrayList parsed;
	private char buildMode = 'n';
	private String builder = "";

	Parser (String _program) {
		program = _program;
		parsed = new ArrayList();
	}

	ArrayList parse() {
		for (char onChar: program.toCharArray()) {
			if (onChar == '"') {
				if (buildMode == 'n') {
					buildMode = 's';
				} else if (buildMode == 's') {
					buildMode = 'n';
					parsed.add(builder);
					builder = "";
				} else if (buildMode == 'd') {
					buildMode = 's';
					parsed.add(parseFloat(builder));
					builder = "";
				} else if (buildMode == 'c') {
					parsed.add(onChar);
					buildMode = 'n';
				}
			} else if (onChar == '\'') {
				if (buildMode == 'c') {
					parsed.add(onChar);
					buildMode = 'n';
				} else if (buildMode == 'n') {
					buildMode = 'c';
				} else if (buildMode == 's') {
					builder += onChar;
				} else if (buildMode == 'd') {
					buildMode = 'c';
					parsed.add(parseFloat(builder));
					builder = "";
				}
			} else if (match(onChar + "", "[\\d.]") != null) {
				if (buildMode == 'n') {
					buildMode = 'd';
					builder += onChar;
				} else if (buildMode == 'd') {
					builder += onChar;
				} else if (buildMode == 's') {
					builder += onChar;
				} else if (buildMode == 'c') {
					parsed.add(onChar);
					buildMode = 'n';
				}
			} else {
				if (buildMode == 'd') {
					buildMode = 'n';
					parsed.add(parseFloat(builder));
					builder = "";
				} else if (buildMode == 's') {
					builder += onChar;
				}
				if (buildMode == 'n') {
					if (match(onChar+"", "[lrgsdER+*/-<=>%]") != null) {
						Operator op = new Operator(onChar + "");
						parsed.add(op);
					}
				}
				if (buildMode == 'c') {
					parsed.add(onChar);
					buildMode = 'n';
				}
			}
			//Debug
			//print((onChar+"") + (buildMode+"") + builder+" ");
		}
		if (buildMode == 'd') {
			parsed.add(parseFloat(builder));
		} else if (buildMode == 's') {
			parsed.add(builder);
		}
		return parsed;
	}
}
