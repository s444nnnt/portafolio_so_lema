/* matriz.c — localidad espacial: recorrer por filas vs por columnas */
#include <stdio.h>
#include <time.h>
#define N 4096
static int a[N][N];                 /* 4096 x 4096 x 4 B = 64 MiB */

int main(int argc, char **argv) {
    int por_columnas = (argc > 1);  /* ./matriz c  -> por columnas */
    for (int i = 0; i < N; i++)     /* inicializar: fuerza páginas reales */
        for (int j = 0; j < N; j++) a[i][j] = i + j;

    long s = 0;
    clock_t t0 = clock();
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            s += por_columnas ? a[j][i] : a[i][j];
    double seg = (double)(clock() - t0) / CLOCKS_PER_SEC;
    printf("%-9s %.3f s  (suma = %ld)\n", por_columnas ? "columnas" : "filas", seg, s);
    return 0;
}
