class Interpreter {
	private String program;
	private String input;
	private ArrayList parsed;
	private ArrayList stack;

	Interpreter (String _program, String _input) {
		program = _program;
		input = _input;
		stack = new ArrayList();
	}

	void run() {
		parse();
		for (Object token: parsed) {
			stack.add(token.toString());
		}
		background(0);
		print(stack);
	}

	void parse() {
		Parser programParser = new Parser(program);
		parsed = programParser.parse();

		Parser inputParser = new Parser(input);
		for (Object inputToken: inputParser.parse()) {
			stack.add(inputToken.toString());
		}
	}
}
