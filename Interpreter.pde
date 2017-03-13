class Interpreter {
	private String program;
	private String[] input;
	private ArrayList parsed;
	private ArratList stack;

	Interpreter (String _program, String[]_input) {
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
	}

	void parse() {
		Parser parser = new Parser(program);
		parsed = parser.parse();
	}
}
