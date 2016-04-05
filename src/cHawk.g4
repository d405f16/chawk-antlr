grammar cHawk;

program
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
    : IDENTIFIER ASSIGNMENT_OPERATORS expression
    ;

function_statement
    : IDENTIFIER ASSIGNMENT_OPERATORS '{' program '}'
    ;

selection_statement
    : 'if' '(' expression ')' '{' program '}'
    | 'if' '(' expression ')' '{' program '}' 'else' '{' program '}'
    ;

iteration_statement
    : 'for' '(' variable_statement 'to' NUMBER 'by' NUMBER ')' '{' program '}'
    | 'while' '(' expression ')' '{' program '}'
    ;

/* EXPRESSIONS */
expression
    : VALUE
    | variable_expression
    | function_expression
    | expression EXPRESSION_OPERATORS expression
    ;

variable_expression
    : IDENTIFIER
    | IDENTIFIER '.' variable_expression
    ;

function_expression
    : IDENTIFIER '(' (named_parameter (',' named_parameter)*)* ')'
    | IDENTIFIER '.' function_expression
    ;

named_parameter
    : variable_statement
    | function_statement
    ;


/* IDENTIFER */
// TODO tal og bogstaver bare ingen tal i starten
IDENTIFIER
    : ALPHABETIC+
    ;


/* VALUES */
VALUE
    : STRING
    | NUMBER
    | ARRAY
    ;

NUMBER
    : '-'? NUMERIC+ '.'? NUMERIC*
    ;

STRING
    : '"' ~('"' | '\n' | '\r')* '"'
    | '\'' ~('\'' | '\n' | '\r')* '\''
    ;

// TODO virker ikke
ARRAY
    : '[' (VALUE (',' VALUE)*)* ']'
    ;

fragment ALPHABETIC: ('a'..'z'|'A'..'Z');
fragment NUMERIC: ('0'..'9');


/* OPERATORS */
ASSIGNMENT_OPERATORS
    : '='
    | '+='
    | '-='
    | '*='
    ;

EXPRESSION_OPERATORS
    : MULTIPLICATIVE_EXPRESSION_OPERATORS
    | ADDITIVE_EXPRESSION_OPERATORS
    | RELATIONAL_EXPRESSION_OPERATORS
    | EQUALITY_EXPRESSION_OPERATORS
    | LOGICAL_EXPRESSION_OPERATORS
    ;

fragment MULTIPLICATIVE_EXPRESSION_OPERATORS: '*' | '/' | '%';
fragment ADDITIVE_EXPRESSION_OPERATORS: '+' | '-';
fragment RELATIONAL_EXPRESSION_OPERATORS: '<' | '>' | '<=' | '>=';
fragment EQUALITY_EXPRESSION_OPERATORS: '==' |  '!=';
fragment LOGICAL_EXPRESSION_OPERATORS: '&&' | '||';

/* REMOVE WHITESPACE */
WHITESPACE: (' ' | '\t' | '\r' | '\n') -> skip;