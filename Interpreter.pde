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
		//println(parsed);
		for (Object _token: parsed) {
			String token = _token.toString();
			//println(stack);
			Object a,b,w,h,x,y;
			//print(typeOf(_token));
			if (typeOf(_token).equals("Operator")) {
				switch (((Operator)_token).getValue()) {
					case "+":
						a = pop();
						b = pop();

						if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
							push(toFloat(a) + toFloat(b));
						} else {
							push(a.toString() + b.toString());
						}
						break;
					case "-":
						a = pop();
						b = pop();

						if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
							push(toFloat(a) - toFloat(b));
						} else {
							//push(a.toString() + b.toString());
						}
						break;
					case "*":
						a = pop();
						b = pop();

						if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
							push(toFloat(a) * toFloat(b));
						} else {
							//push(a.toString() + b.toString());
						}
						break;
					case "/":
						a = pop();
						b = pop();

						if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
							push(toFloat(a) / toFloat(b));
						} else {
							//push(a.toString() + b.toString());
						}
						break;
					case "<":
						a = pop();
						b = pop();

						if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
							push(toFloat(a) < toFloat(b) ? 1.0 : 0.0);
						} else {
							push(a.toString().compareTo(b.toString()) < 0 ? 1.0 : 0.0);
						}
						break;
					case "=":
						a = pop();
						b = pop();

						if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
							push(toFloat(a) == toFloat(b) ? 1.0 : 0.0);
						} else {
							push(a.toString().equals(b.toString()) ? 1.0 : 0.0);
						}
						break;
					case ">":
						a = pop();
						b = pop();

						if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
							push(toFloat(a) > toFloat(b) ? 1.0 : 0.0);
						} else {
							push(a.toString().compareTo(b.toString()) > 0 ? 1.0 : 0.0);
						}
						break;
					case "%":
						a = pop();
						b = pop();

						if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
							push(toFloat(a) % toFloat(b));
						} else {
							//push(a.toString() + b.toString());
						}
						break;
					case "^":
						a = pop();
						b = pop();

						if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
							push(pow( toFloat(a), toFloat(b) ));
						} else {
							//push(a.toString() + b.toString());
						}
						break;
					case "!":
						a = pop();

						if (typeOf(a).equals("Float")) {
							push(toFloat(a) == 0.0 ? 1.0 : 0.0);
						} else {
							//push(a.toString() + b.toString());
						}
						break;
					case "d":
						//duplicate
						a = pop();
						push(a);
						push(a);
						break;
					case "s":
						//swap
						a = pop();
						b = pop();
						push(a);
						push(b);
						break;
					case "g":
						//get
						a = pop();
						Object element = get((int) toFloat(a));
						remove((int) toFloat(a));
						push(element);
						break;
					case "r":
						//remove top element
						a = pop();
						break;
					case "c":
						//clear stack
						stack = new ArrayList();
						break;
					case "C":
						//case int to char
						a = pop();

						if (typeOf(a).equals("Float")) {
							push((char) round(toFloat(a)));
						} else {
							//push(a.toString() + b.toString());
						}
						break;
					case "P":
						//print
						a = pop();
						print(a.toString());
						push(a);
						break;
					case "p":
						//print
						a = pop();
						print(a.toString());
						break;
					case "E":
						//ellipse
						h = pop();
						w = pop();
						y = pop();
						x = pop();
						ellipse(toFloat(x), toFloat(y), toFloat(w), toFloat(h));
						break;
					case "R":
						//rectangle
						h = pop();
						w = pop();
						y = pop();
						x = pop();
						rect(toFloat(x), toFloat(y), toFloat(w), toFloat(h));
						break;
				}
			} else {
				push(_token);
			}
		}
		//background(0);
		print(stack);
	}

	void parse() {
		Parser programParser = new Parser(program);
		parsed = programParser.parse();

		Parser inputParser = new Parser(input);
		for (Object inputToken: inputParser.parse()) {
			push(inputToken);
		}
	}

	String typeOf(Object object) {
		return object.getClass().getName().replaceAll("java.lang.|Processtack\\$","");
	}

	Object pop() {
		Object lastElement = stack.get(stack.size()-1);
		stack.remove(stack.size()-1);
		return lastElement;
	}

	void push(Object object) {
		stack.add(object);
	}

	Object get(int i) {
		return stack.get(i);
	}

	void remove(int i) {
		stack.remove(i);
	}

	float toFloat(Object i) {
		return parseFloat(i.toString());
	}
}
