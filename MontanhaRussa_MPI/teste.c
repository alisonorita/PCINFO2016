#include "stddef.h"
#include "mpi.h"
#include "stdio.h"
#include "string.h"

void main(int argc, char *argv[]){
	char message[20];
	int i, rank, size, tag = 99;
	MPI_Status status;
	MPI_Init(&argc, &argv);
	MPI_Comm_size(MPI_COMM_WORLD, &size);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	if(rank == 0){
		strcpy(message, "Hello world!");
		for (i = 1; i < size; i++) {
			MPI_Send(message, 12, MPI_CHAR, i, tag, MPI_COMM_WORLD);
			printf("Mensagem enviada do processo 0 para o processo %d!\n", i);
		}
	} else {
		MPI_Recv(message, 12, MPI_CHAR, 0, tag, MPI_COMM_WORLD, &status);
		printf("Mensagem recebida pelo processo %d : %.12s\n", rank, message); 
	}
	MPI_Finalize();
}
