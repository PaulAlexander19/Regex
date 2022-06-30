%{
int flag_operador1=0,flag_operador2=0;
void evaluate();
float operador1=0, operador2=0, respuesta=0;

char tipoOperation = '0';
%}
DIGIT [0-9]
NUM {DIGIT}+(\.{DIGIT}+)?
%%

st { printf("operador1: %f operador2: %f, respuesta: %f, flag_operador1: %d, flag_operador2: %d, tipoOperation: %c\n", operador1, operador2, respuesta, flag_operador1, flag_operador2, tipoOperation );}
{NUM} { 
	if (flag_operador1 == 0){
		operador1 = atof(yytext);
		flag_operador1 = 1;
		printf("operador 1: %0.2f\n", operador1);
	}
	else if(flag_operador2 == -1){
		operador2 = atof(yytext);
		flag_operador2 = 1;
		printf("operador 2: %0.2f\n", operador2);
	}
	if((flag_operador1 == 1) && (flag_operador2 == 1)) {
		flag_operador1 = 0;
		flag_operador2 = 0;
	}
			}
[+] {
	printf("es suma\n");
	tipoOperation='+';
	flag_operador2 = -1;
}
[-] {
	printf("es resta\n");
	tipoOperation='-';
	flag_operador2 = -1;
}
[*] {
	printf("es multiplicacion\n");
	tipoOperation='*';
	flag_operador2 = -1;
}
[\/] {
	printf("es division\n");
	tipoOperation='/';
	flag_operador2 = -1;
}
[%] {
	printf("es modulo\n");
	tipoOperation='%';
	flag_operador2 = -1;
}
[\^] {
	printf("es potencia\n");
	tipoOperation='^';
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
long potenciaConWhile(long numero, long potencia){
    long resultado = numero;
    while (potencia > 1)
    {
        resultado = resultado * numero;
        potencia--;
    }
    return resultado;
}

void evaluate(){
	if(tipoOperation == '0'){
		printf("Operador no registrado");
		return;
	}else if(tipoOperation == '+'){
		respuesta = operador1 + operador2;
	}else if(tipoOperation == '-'){
		respuesta = operador1 - operador2;
	}else if(tipoOperation == '*'){
		respuesta = operador1 * operador2;
	}else if(tipoOperation == '/'){
		respuesta = operador1 / operador2;
	}else if(tipoOperation == '%'){
		respuesta = (int)operador1 % (int)operador2;
	}else if(tipoOperation == '^'){
		respuesta = potenciaConWhile(operador1, operador2);
	}

	printf("respuesta es: %0.2f\n", respuesta);
}


