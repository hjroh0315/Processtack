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
				} if (buildMode == 'd') {
					buildMode = 's';
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
					if (match(onChar+"", "[lrgsd+*/-]") != null) {
						parsed.add(onChar + "");
					}
				}
			}
			//Debug
			//print((onChar+"") + (buildMode+"") + " ");
		}
		if (buildMode == 'd') {
			parsed.add(parseFloat(builder));
		} else if (buildMode == 's') {
			parsed.add(builder);
		}
		return parsed;
	}
}
