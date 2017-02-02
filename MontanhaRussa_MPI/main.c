#include "stdio.h"
#include "stdlib.h"
#include "mpi.h"

#define N 10
#define CAP 3

int rank;
int size;
MPI_Status status;

void embarcarPass(int passID, int carrID) {
    if (passID != -1) {
        printf("Passageiro ID:%d embarcou no carrinho %d\n", passID, carrID);
    } else {
        printf("Nao tem mais passageiros\n");
    }
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
        embarcarPass(idPass, carrID);
        MPI_Send(&idPass, 1, MPI_INT, carrID, 0, MPI_COMM_WORLD);
        passAtendido++;
        sleep(1);
    }

	while (carrFim < size - 1) {
        MPI_Recv(&nPass, 1, MPI_INT, MPI_ANY_SOURCE, 0, MPI_COMM_WORLD, &status);

        if (passAtendido < N) {
            idPass = getIDPassageiro;
            embarcarPass(idPass, status.MPI_SOURCE);
            MPI_Send(&idPass, 1, MPI_INT, status.MPI_SOURCE, 0, MPI_COMM_WORLD);
            passAtendido++;
            sleep(1);
        } else {
            idPass = -1;
            embarcarPass(idPass, status.MPI_SOURCE);
            MPI_Send(&idPass, 1, MPI_INT, status.MPI_SOURCE, 0, MPI_COMM_WORLD);
            carrFim++;
        }
	}

    printf("\nAcabou passageiros!\n");
}

void carrinho() {
	int idPass, nPassNoCarr=0;

	while (1) {
		MPI_Recv(&idPass, 1, MPI_INT, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);

		if (idPass == -1) {
            printf("Carrinho %d realizou o passeio\n\n", rank);
            break;
        } else {
            nPassNoCarr++;

            if (nPassNoCarr < CAP) {
                printf("Carrinho %d estah aguardando (%d/%d)\n", rank,nPassNoCarr,CAP);
                MPI_Send(&nPassNoCarr, 1, MPI_INT, 0, 0, MPI_COMM_WORLD);
            } else {
                printf("Carrinho %d realizou o passeio\n\n", rank);
                MPI_Send(&nPassNoCarr, 1, MPI_INT, 0, 0, MPI_COMM_WORLD);
                nPassNoCarr = 0;
            }
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

    MPI_Finalize();
}
	

