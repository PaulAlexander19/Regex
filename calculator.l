%{
int flag_operador1=0,flag_operador2=0;
void evaluate();
float operador1=0, operador2=0, respuesta=0;
char tipoOperation='0';
%}
DIGIT [0-9]
NUM {DIGIT}+(\.{DIGIT}+)?
%%
{DIGIT} { printf("numero entero\n");}
{NUM} {
	if (flag_operador1 == 0){
		operador1 = atof(yytext);
		flag_operador1 = 1;
		printf(" -> Operador 1: %0.2f\n", operador1);
	}
	else if(flag_operador2 == -1){
		operador2 = atof(yytext);
		flag_operador2 = 1;
		printf("-> Operador 2: %0.2f\n", operador2);
	}
	if((flag_operador1 == 1) && (flag_operador2 == 1)) {
		flag_operador1 = 0;
		flag_operador2 = 0;
	}
}
[+\-*\/%\^] {
	tipoOperation = yytext[0];
	printf("-> Operacion: %c\n", tipoOperation);
	flag_operador2 = -1;
}
[\n] {
	evaluate();
	if((flag_operador1 == 1) && (flag_operador2 == 1)) {
		flag_operador1 = 0;
		flag_operador2 = 0;
	}
}
%%
int yywrap(){}
int main(){
	yylex();
	return 0;
}
float potenciaConWhile(float numero, float potencia){
    float resultado = numero;
    while (potencia > 1){
        resultado = resultado * numero;
        potencia--;
    }
    return resultado;
}
void evaluate(){
	switch(tipoOperation){
		case '+':	respuesta = operador1 + operador2; break;
		case '-': respuesta = operador1 - operador2; break;
		case '*': respuesta = operador1 * operador2; break;
		case '/': respuesta = operador1 / operador2; break;
		case '%': respuesta = (int)operador1 % (int)operador2; break;
		case '^': respuesta = potenciaConWhile(operador1, operador2); break;
		default : printf("NO SE RECONOCE LA OPERACION\n");
							operador1 = 0;
							operador2 = 0;
							flag_operador1 = 0;
							flag_operador2 = 0;
	}
		printf(" -> Respuesta es: %0.2f\n", respuesta);
}
