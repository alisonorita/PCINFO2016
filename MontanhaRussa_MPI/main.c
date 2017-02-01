#include "stdio.h"
#include "stdlib.h"
#include "mpi.h"

#define N 10
#define CAP 3

int rank;
int size;
MPI_Status status;

void embarcarPass(int passID, int carrID) {
	printf("Passageiro ID:%d embarcou no carrinho %d\n", passID, carrID);
}

int getIDPassageiro() {
	time_t t;
	int passID = rand()%500;
	return passID;
}

void controleCarr() {
	int carrID, idPass;
	int carrFim = 0;
	int passAtendido = 0;
	int nPass;

    for (carrID=1; carrID<size; carrID++) {
        idPass = getIDPassageiro;
        MPI_Send(&idPass, 1, MPI_INT, carrID, 0, MPI_COMM_WORLD);
        passAtendido++;
    }

	while (carrFim < size - 1) {
        MPI_Recv(&nPass, 1, MPI_INT, MPI_ANY_SOURCE, 0, MPI_COMM_WORLD, &status);

        /*
        if ((nPass == CAP) || (nPass == N)) {
            passAtendido += nPass;
            printf("\nPassageiros atendidos: %d\n\n",passAtendido);
        }
        */

        if (passAtendido < N) {
            idPass = getIDPassageiro;
            MPI_Send(&idPass, 1, MPI_INT, status.MPI_SOURCE, 0, MPI_COMM_WORLD);
            passAtendido++;
        } else {
            idPass = -1;
            MPI_Send(&idPass, 1, MPI_INT, status.MPI_SOURCE, 0, MPI_COMM_WORLD);
            carrFim++;
        }
	}

    printf("Acabou o passeio!");
    MPI_Finalize();
}

void carrinho() {
	int idPass, nPassNoCarr=0;

	while (1) {
		MPI_Recv(&idPass, 1, MPI_INT, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);

		embarcarPass(idPass,rank);
		nPassNoCarr++;

		if ((nPassNoCarr < CAP) && (nPassNoCarr != N) && (idPass != -1)) {
			printf("Carrinho %d estah aguardando (%d/%d)\n", rank,nPassNoCarr,CAP);
			MPI_Send(&nPassNoCarr, 1, MPI_INT, 0, 0, MPI_COMM_WORLD);
		} else {
			//tag 1 simboliza que o carrinho está cheio
			printf("\nCarrinho %d realizou o passeio\n\n", rank);
			MPI_Send(&nPassNoCarr, 1, MPI_INT, 0, 0, MPI_COMM_WORLD);
            nPassNoCarr = 0;
		}
	}
}

void main(int argc, char* argv[]) {
	MPI_Init(NULL, NULL);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Comm_size(MPI_COMM_WORLD, &size);

	if (rank == 0) {
		controleCarr();
	} else {
		carrinho();
	}
}
	

