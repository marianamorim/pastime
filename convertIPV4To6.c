#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int main(){
	int num1;
 	char num[15];
	char numEmHexa[15];
	char charHexa[16] = {'0', '1', '2', '3', '4', '5', '6', '7', 
			     '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
	char * semPonto;

	printf("Digite o endereco IPV4 p/ converter p/ IPV6: ");
	scanf("%s", &num);

	printf("IPV4 Lido: %s\n", num);

	semPonto = strtok (num,".");
	
	printf("Convertido IPV6: ");

	while(semPonto != NULL)
	{
		num1 = atoi(semPonto);	
		numEmHexa[0] = charHexa[ ((num1 & 0xF0) >> 4) ];
		numEmHexa[1] = charHexa[ (num1 & 0x0F) ];
		numEmHexa[2] = '\0';
		
		printf("%s", numEmHexa); 
		semPonto = strtok (NULL, " ,.-");
	}

	return 0;
}
