/*
for loop

*/

grammar cHawk;

program
    : statement_expression setup statement_expression route statement_expression
    ;

statement_expression
    : (statement | expression)*
    ;


/* STATEMENTS */
statement
    : variable_statement
    | function_statement
    | selection_statement
    | iteration_statement
    ;

variable_statement
    : IDENTIFIER '=' expression
    | KEYWORD '.' IDENTIFIER '=' expression
    ;

function_statement
    : IDENTIFIER '=' '{' statement_expression '}'
    | KEYWORD '.' IDENTIFIER '=' '{' statement_expression '}'
    ;

setup
    : 'setup' '=' '{' statement_expression '}'
    ;

route
    : 'route' '=' '{' statement_expression '}'
    ;

selection_statement
    : 'if' '(' expression ')' '{' statement_expression '}'
    | 'if' '(' expression ')' '{' statement_expression '}' 'else' '{' statement_expression '}'
    ;

iteration_statement
    : 'for' '(' variable_statement 'to' NUMBER 'by' NUMBER ')' '{' statement_expression '}' // TODO for loops virker ikke
    | 'while' '(' expression ')' '{' statement_expression '}'
    ;


/* EXPRESSIONS */
expression
    : '(' expression ')'
    | VALUE
    | IDENTIFIER
    | KEYWORD '.' IDENTIFIER
    | expression '[' expression? ']'
    | expression '(' (named_parameter (',' named_parameter)*)? ')'
    | expression ('*' | '/' | '%') expression
    | expression ('+' | '-') expression
    | expression ('<' | '<=' | '>' | '>=') expression
    | expression ('==' | '!=' ) expression
    | expression '&&' expression
    | expression '||' expression
    ;

named_parameter
    : variable_statement
    | function_statement
    ;


/* LEXER*/
VALUE
    : BOOLEAN
    | NUMBER
    | STRING
    ;

BOOLEAN
    : ('true' | 'TRUE')
    | ('false' | 'FALSE')
    ;

NUMBER
    : NUMERIC+ ('.' NUMERIC+)?
    ;

//NUMBER // TODO fix negative tal
//    : '-'? NUMERIC+ '.'? NUMERIC*
//    ;

STRING
    : '"' ~('"' | '\n' | '\r')* '"'
    | '\'' ~('\'' | '\n' | '\r')* '\''
    ;

KEYWORD
    : 'setup'
    | 'route'
    | 'events'
    | 'drone'
    | 'param'
    ;

IDENTIFIER
    : ALPHABETIC+ (ALPHABETIC | NUMERIC)*
    ;

fragment ALPHABETIC: ('a'..'z'|'A'..'Z');
fragment NUMERIC: ('0'..'9');


/* REMOVE WHITESPACE */
WHITESPACE: (' ' | '\t' | '\r' | '\n') -> skip;


