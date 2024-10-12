%{
#include <math.h>
#include <stdio.h>
#include <stdbool.h>
int yylex();
void yyerror(char*s);
%}

%union{
	int num;
	char sym;
	float flo;
	long lo;	
	
}
%token ELSE FOR EQ FLOAT LPAREN RPAREN SIN COS TAN SQRT EOL NUMBER PLUS DIV MULT SUB IF ADD LT MT LTEQ MTEQ 
%type<num> NUMBER
%type<num> loop Ifelse

%type<lo> Factor Sqr Exp Term
%type<flo> Trig FLOAT
%type<num> Cond
%%

First:
|     program First;
program: 
     Exp EOL {printf("%d\n",$1);}
|    Sqr EOL {printf("%d\n", $1); }
|    Trig EOL {printf("%f\n", $1); }
|    Ifelse EOL {if($1 == 0){
		printf(" ");}
		else{
		printf("%d\n",$1); }
		}
|    loop EOL {printf("%d\n", $1); }
|    EOL;
Exp:   Factor
|      Exp PLUS Factor { $$ = $1 + $3; }
|      Exp SUB Factor { $$ = $1 - $3; }
|     
;
Factor: Term
|      Factor MULT Term { $$ = $1 * $3; }
|      Factor DIV Term  { $$ = $1 / $3; }
|      Factor MULT Sqr  { $$ = $1 * $3; }
|      Factor DIV Sqr   { $$ = $1 * $3; }
|      Sqr		{$$ = $1; }
;

Term: NUMBER;


Sqr:
   SQRT LPAREN Term RPAREN { $$ = sqrt($3); }
|  SQRT LPAREN Exp RPAREN {$$ = sqrt($3); }
|  SQRT LPAREN Factor RPAREN {$$ = sqrt($3); };
Trig:
   SIN LPAREN FLOAT RPAREN  { $$ = sin($3);  }
|  COS LPAREN FLOAT RPAREN  { $$ = cos($3);  }
|  TAN LPAREN FLOAT RPAREN  { $$ = tan($3);  }
|  SIN LPAREN FLOAT RPAREN Exp { $$ = sin($3) + $5; }
|  COS LPAREN FLOAT RPAREN Exp { $$ = cos($3) + $5; }
|  TAN LPAREN FLOAT RPAREN Exp { $$ = tan($3) + $5; }
|  Exp SIN LPAREN FLOAT RPAREN {$$ = sin($4) + $1; }
|  Exp COS LPAREN FLOAT RPAREN {$$ = $1 + cos($4); }
|  Exp TAN LPAREN FLOAT RPAREN {$$ = $1 + tan($4); };

Ifelse:
	   IF LPAREN Cond RPAREN Exp ELSE Exp { if($3){
						 printf("IF ACCEPTED\n");
						 ($$ = $5);}
						  
						 else{
						 
						   ($$ = $7); };
							}

|	 IF LPAREN Cond RPAREN Exp{ if($3){
					($$ = $5);}
				    else{
					printf("NOPE");};
					};
							 

loop:
    FOR LPAREN NUMBER RPAREN Exp PLUS Exp {
						for(int i = 0; i < $3; i++){
						  $5 = $5 + $7; };
						($$ = $5);
						};
	
						
Cond:
    NUMBER EQ NUMBER { if($1 == $3){
			   ($$ = 1);}
			else{
			($$ = 0); };
			   }

|  NUMBER LTEQ NUMBER { if($1 <= $3){
			($$ = 1);}
			else{
			 ($$ = 0);};
			}
| NUMBER MTEQ NUMBER { if($1 >= $3){
			($$ = 1);}
			else{
			  ($$ = 0);};
			};


%%			   	

int main(void){
  yyparse();
}

void yyerror(char*s){
  printf("ERROR: %s\n",s);

  
}

