#include <stdio.h>
#include <stdlib.h>
#include <time.h>
struct Node{
	int num;
	struct Node *prox;
};

typedef struct Node node;
int tam;

int menu(void);
void opcao(node *FILA, int op);
void inicia(node *FILA);
int vazia(node *FILA);
node *aloca();
void insere(node *FILA);
node *retira(node *FILA);
void exibe(node *FILA);
void libera(node *FILA);


void inicia(node *FILA)
{
	FILA->prox = NULL;
	tam=0;
}

int vazia(node *FILA)
{
	if(FILA->prox == NULL)
		return 1;
	else
		return 0;
}

node *aloca()
{
	node *novo=(node *) malloc(sizeof(node));
	if(!novo){
		printf("Sem memoria disponivel!\n");
		exit(1);
	}else{
		printf("Passageiro "); scanf("%d", &novo->num);
		return novo;
	}
}

void insere(node *FILA)
{
	node *novo=aloca();
	novo->prox = NULL;

	if(vazia(FILA))
		FILA->prox=novo;
	else{
		node *tmp = FILA->prox;

		while(tmp->prox != NULL)
			tmp = tmp->prox;

		tmp->prox = novo;
	}
	tam++;
}


node *retira(node *FILA)
{
	if(FILA->prox == NULL){
		printf("Fila ja esta vazia\n");
		return NULL;

	}else{
		node *tmp = FILA->prox;
		FILA->prox = tmp->prox;
		tam--;
		return tmp;
	}

}
void libera(node *FILA)
{
	if(!vazia(FILA)){
		node *proxNode,
			  *atual;

		atual = FILA->prox;
		while(atual != NULL){
			proxNode = atual->prox;
			free(atual);
			atual = proxNode;
		}
	}
}

void exibe(node *FILA)
{
	if(vazia(FILA)){
		printf("Fila vazia!\n\n");
		return ;
	}

	node *tmp;
	tmp = FILA->prox;
	printf("Fila :");
	while( tmp != NULL){
		printf("%5d", tmp->num);
		tmp = tmp->prox;
	}
	printf("\n        ");
	int count;
	for(count=0 ; count < tam ; count++)
		printf("  ^  ");
	printf("\nOrdem:");
	for(count=0 ; count < tam ; count++)
		printf("%5d", count+1);


	printf("\n\n");
}

void pause (float);

void pause (float delay1) {

   if (delay1<0.001) return; // pode ser ajustado e/ou evita-se valores negativos.

   float inst1=0, inst2=0;

   inst1 = (float)clock()/(float)CLOCKS_PER_SEC;

   while (inst2-inst1<delay1) inst2 = (float)clock()/(float)CLOCKS_PER_SEC;

   return;

}


int main(int argc, char* argv[]) {
	node *FILA = (node *) malloc(sizeof(node));

	node *tmp;

	if(!FILA){
		printf("Sem memoria disponivel!\n");
		exit(1);
	}else{
	inicia(FILA);


    int carroCapacidade,numeroPassageiros;
    int i,k,j,h;




    do {
                printf("Numero de passageiros: ");
                scanf("%i", &numeroPassageiros);


    } while (numeroPassageiros <= 0);

        for(i=0;i<numeroPassageiros;i++){
            insere(FILA);
        }
do {
                printf("Numero de passageiros por carro: ");
                scanf("%i", &carroCapacidade);
    } while (carroCapacidade <= 0);

    while(FILA->prox!= NULL){
    for(j=0;j<carroCapacidade;j++){
        printf("Passageiro %i entrando no carrinho\n",j );
        tmp= retira(FILA);
        if(FILA->prox == NULL){
                break;
    }
    }
    printf("\nCarrinho partindo para a aventura \o/\n");
    pause(4);
    printf("ahhhh mas ja acabou :(\n");
    if(FILA->prox == NULL){
            printf("\nCabo a galera... Vamo fica pobre T-T\n");
        break;
    }
    pause(4);
    printf("\nOto povo entra\n");

    }

    return 0;
     }
}

