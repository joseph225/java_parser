%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
char *progname;
%}

%{

%}

%token	NUMBER ID
%token  IF ELSE FOR WHILE BREAK CONTINUE
%token  INCREMENT DECREMENT LPAREN RPAREN SEMICOLON COLON
%token	LT GT LTE GTE ADD SUB MUL DIV MOD EQ NEQ AND OR TRUE FALSE ASSIGN COMMA OB CB NOT INT
%%
statement: if_then_else_statement 
		| while_statement 
		| for_statement 
		| OB statement CB 
		| OB statement_without_trailing_substatement statement CB 
		| OB statement statement_without_trailing_substatement CB 
		| OB statement_without_trailing_substatement statement statement_without_trailing_substatement CB 
		| statement_without_trailing_substatement 
		| labeled_statement 
		;

expression:	conditions
		| boolean
		;

assignment:	variable_declarator
		;

conditions:	condition AND conditions |
		condition OR conditions |
		condition ;

condition:	factor relop factor |
		NOT factor relop factor ;

factor:	ID |
	NUMBER ;

relop: GT | LT | GTE | LTE | EQ | NEQ;


for_statement:	FOR LPAREN for_init SEMICOLON expression SEMICOLON for_update RPAREN  statement   
		| FOR LPAREN empty_statement empty_statement empty_statement RPAREN  statement  
		;

for_init:	local_variable_declaration
		;

for_update:	statement_expression_list
		;

while_statement: WHILE LPAREN expression RPAREN statement 
			;

if_then_else_statement:	matched_statement 
			| unmatched_statement 
			;

matched_statement:	IF LPAREN expression RPAREN matched_statement ELSE matched_statement | OB block CB | block_statement
		;

unmatched_statement:	IF LPAREN expression RPAREN if_then_else_statement 
			| IF LPAREN expression RPAREN matched_statement ELSE unmatched_statement
			;

statement_without_trailing_substatement: block
						;

break_statement:	BREAK SEMICOLON
			;

continue_statement:	CONTINUE SEMICOLON
			;

statement_expression:	assignment
			| postfix_expression
			| prefix_expression
			;

postfix_expression:	variable_declarator_ID INCREMENT
			| variable_declarator_ID DECREMENT
			;


prefix_expression:	INCREMENT variable_declarator_ID 
			| DECREMENT variable_declarator_ID
			;

block:	 block_statements 
	;

block_statements:	block_statement
			| block_statements block_statement
			;

block_statement:	local_variable_declaration_statement SEMICOLON	| empty_statement
						| break_statement
						| continue_statement	
			;

local_variable_declaration_statement:	local_variable_declaration
					;

local_variable_declaration:	type variable_declarator |  variable_declarator 
				;

type:	primitive_type
	;

primitive_type:	boolean | INT
		;

boolean:	TRUE
		| FALSE
		;

op: ADD | SUB | MUL | DIV | MOD;

variable_declarator:	variable_declarator_ID
			| variable_declarator_ID ASSIGN NUMBER 
			| variable_declarator_ID ASSIGN  variable_declarator_ID op NUMBER 
			| variable_declarator_ID ASSIGN  variable_declarator_ID op variable_declarator_ID 
			| postfix_expression 
			| prefix_expression 
			| variable_declarator_ID ASSIGN  NUMBER op variable_declarator_ID 
			| variable_declarator_ID ASSIGN variable_declarator_ID 
			;

variable_declarator_ID: ID
			;

empty_statement:	SEMICOLON
			;

labeled_statement:	identifier COLON OB block CB
			;

statement_expression_list:	statement_expression
				| statement_expression_list COMMA statement_expression	
				;

identifier:	ID
		;
	

%%
	/* end of grammar */

#include"lex.yy.c"

void yyerror(const char *str) {
	fprintf(stderr, "\nAt Line %d : %s\n", yylineno, str);

}
int main(int argc, char *argv[]) {
    yyin = fopen(argv[1], "r");
    
    int status=yyparse();
    if(status==0){
    	printf("\nVALID\n");
    }
    else{
    	printf("\nError\n");
    }
    fclose(yyin);
}





