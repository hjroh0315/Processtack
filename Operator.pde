class Operator {
	//class for distinguishing between char+strings vs operators
	private String value;

	Operator(String _value) {
		this.value = _value;
	}

	String getValue() {
		return this.value;
	}
}
