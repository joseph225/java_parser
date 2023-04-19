%option yylineno
%%
[ \t\n]	;	/* Ignore Whitespace */
[0-9]+	return NUMBER;
int return INT;
if	return IF;
else	return ELSE;
for	return FOR;
while	return WHILE;
break	return BREAK;
continue	return CONTINUE;
"++"	return INCREMENT;
"--"	return DECREMENT;
"("	return LPAREN;
")"	return RPAREN;
";"	return SEMICOLON;
":"	return COLON;
"<"	return LT;
">"	return GT;
"<="	return LTE;
">="	return GTE;
"+"	return ADD;
"-"	return SUB;
"*"	return MUL;
"/"	return DIV;
"%"	return MOD;
"=="	return EQ;
"!="	return NEQ;
"&&"	return AND;
"||"	return OR;
"true"	return TRUE;
"false"	return FALSE;
"="	return ASSIGN;
","	return COMMA;
[a-zA-Z][_a-zA-Z0-9]* return ID;
"{" return OB;
"}" return CB;
"!" return NOT;
%%
