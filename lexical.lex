%{

#include "parser.tab.h"


%}

%%

[0-9]+	{ yylval.num = atoi(yytext); return NUMBER; }
[.][0-9]+ { yylval.flo = atof(yytext); return FLOAT; }
"+" 	{ return PLUS;} 
"="     { return EQ; }
"-" 	{ return SUB; }
"/" 	{ return DIV; }

"*"	{ return MULT; }
"("	{ return LPAREN; }
")"	{ return RPAREN; }
"sqrt"  { return SQRT; }
"sin"   { return SIN;  }
"cos"   { return COS;  }
"tan"   { return TAN;  }
\n	{ return EOL; } 
. {}
"if"    { return IF;  }
"else"  { return ELSE; }
"add"   { return ADD; }
"for"   { return FOR; }
"<"     { return LT;  }
">"     { return MT; }
">="    { return MTEQ; }
"<="    { return LTEQ; }
%%



yywrap() {}
