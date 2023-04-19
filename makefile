TEST_FILE_NAME = test_9
LEX_FILE_NAME = java
YACC_FILE_NAME = java

build:
	lex $(LEX_FILE_NAME).lex
	yacc -v $(YACC_FILE_NAME).yacc

run: 
	gcc -Wall y.tab.c -ll -o java

test:		
	./java $(TEST_FILE_NAME).txt

clean:
	rm -f lex.yy.c y.tab.c java	y.output

all: clean build run test
