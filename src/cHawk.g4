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
    | IDENTIFIER '.' IDENTIFIER '=' expression
    | IDENTIFIER '=' '[' (expression (',' expression)*)? ']'
    ;

function_statement
    : IDENTIFIER '=' '{' statement_expression '}'
    | IDENTIFIER '.' IDENTIFIER '=' '{' statement_expression '}'
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
    : 'for' '(' variable_statement 'to' NUMBER 'by' NUMBER ')' '{' statement_expression '}'
    | 'while' '(' expression ')' '{' statement_expression '}'
    ;


/* EXPRESSIONS */
expression
    : value
    | '(' expression ')'
    | ('!' | '+' | '-') expression

    | variable_expression
    | function_expression


    | expression ('*' | '/' | '%') expression
    | expression ('+' | '-') expression
    | expression ('<' | '<=' | '>' | '>=') expression
    | expression ('==' | '!=' ) expression
    | expression '&&' expression
    | expression '||' expression
    ;

variable_expression
    : IDENTIFIER
    | IDENTIFIER '[' expression? ']'
    | IDENTIFIER '.' variable_expression
    ;

function_expression
    : IDENTIFIER '(' (named_parameter (',' named_parameter)*)? ')'
    | IDENTIFIER '.' function_expression
    ;

named_parameter
    : variable_statement
    | function_statement
    ;


/* DATATYPES */
value
    : BOOLEAN
    | NUMBER
    | STRING
    ;

BOOLEAN
    : ('true' | 'TRUE')
    | ('false' | 'FALSE')
    ;

NUMBER
    : DIGIT+ ('.' DIGIT+)?
    ;

STRING
    : '"' ~('"' | '\n' | '\r')* '"'
    | '\'' ~('\'' | '\n' | '\r')* '\''
    ;

IDENTIFIER
    : CHARACTER+ (CHARACTER | DIGIT)*
    ;

fragment CHARACTER: ('a'..'z'|'A'..'Z');
fragment DIGIT: ('0'..'9');


/* REMOVE WHITESPACE */
WHITESPACE: (' ' | '\t' | '\r' | '\n') -> skip;


