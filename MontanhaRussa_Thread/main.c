#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <semaphore.h>
#include <pthread.h>

#define MAX_PASSENGERS 500

sem_t sPass, sCarrinho;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

int nPass, cap, nPassCarrinho, nPassRestante;
int listaPass[MAX_PASSENGERS];
int listaThread[MAX_PASSENGERS];

void inicializar() {
    sem_init(&sPass, 0, cap);
    sem_init(&sCarrinho, 0, 0);

    pthread_mutex_init(&mutex, NULL);
}

void carregarVariaveis() {
    printf("Numero de passageiros (<500): ");
    scanf("%d", &nPass);
    printf("Numero de passageiros por carrinho: ");
    scanf("%d", &cap);
    printf("\n");

    nPassCarrinho = 0;
    nPassRestante = nPass;
}

void finalizar() {
    sem_destroy(&sPass);
    sem_destroy(&sCarrinho);

    pthread_mutex_destroy(&mutex);
}

int getPassID() {
    return rand() % 500;
}

void *passageiro (void* tID) {
    sem_wait(&sPass);

    pthread_mutex_lock(&mutex);

    int passID;
    int threadID;

    passID = getPassID();
    threadID = (long) tID; //achei no stackoverflow que isso funciona (converte void > int)

    printf("passageiro[id:%d].entrar() - thread: %d\n", passID, threadID);

    nPassCarrinho += 1;

    listaPass[nPassCarrinho] = passID;
    listaThread[nPassCarrinho] = threadID;

    nPassRestante -= 1;

    if ((nPassCarrinho == cap) || (nPassRestante == 0))
        sem_post(&sCarrinho);

    pthread_mutex_unlock(&mutex);
}

void *carrinho (void *vazio) {
    while ((nPassRestante+nPassCarrinho) > 0) {
        sem_wait(&sCarrinho);

        pthread_mutex_lock(&mutex);

        printf("carrinho.passear()\n");

        for (int i = 1; i <= nPassCarrinho; i++) {
            sem_post(&sPass);
            printf("passageiro[id:%d].descer() - thread: %d\n", listaPass[i], listaThread[i]);

        }
        nPassCarrinho = 0;


        printf("carrinho.esperando()\n\n");

        pthread_mutex_unlock(&mutex);
    }
}

int main () {
    carregarVariaveis();
    inicializar();

    pthread_t tCarrinho;
    pthread_t tPassageiro[MAX_PASSENGERS];

    for (int i = 1; i <= nPass; i++) {
        if (pthread_create(&tPassageiro[i], NULL, passageiro, (void *) i)) {
            printf("Erro na criacao da thread!");
        };
    }

    pthread_create(&tCarrinho, NULL, carrinho, NULL);

    pthread_exit(NULL);

    finalizar();

    return 0;
}
