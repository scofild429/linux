/* #include <stdio.h> */
/* #include <stdlib.h> */
/* #include <string.h> */

/* int dichotomy(int **p, int *start, int *end, int x){ */
/*   if (*p == NULL) { */
/*     printf(" This array is empty !\n"); */
/*     return -1; */
/*   } */
/*   if (x < *start || x > *end) { */
/*     printf("this element is not in the array\n"); */
/*     return -1; */
/*   } */
/*   if (x == *start || x == *end) { */
/*     return x; */
/*   } */
/*   int len = 0; */
/*   for (int *temp = *p; *temp != *end; temp++) { */
/*     len++; */
/*   } */

/*   int mid = *(*p+len/2); */
/*   if (mid == *start || x == *end) { */
/*     return -1; */
/*   } */

/*   if (mid >= x) { */
/*     return dichotomy(p, start, &mid, x); */
/*   }else { */
/*     int * newp = *p+len/2; */
/*     return dichotomy(&newp, &mid, end, x); */
/*   } */
/* } */

/* int main(int argc, char *argv[]) */
/* { */
/*   int array[] = {1,3,7,12,45,78,234,678,5678}; */
/*   int x = 690; */
/*   int *p = array; */
/*   int *start = array; */
/*   int *end1 = &array[8]; */
/*   int *end = (int *)(&array+1); */
/*   int a = dichotomy(&p, start, (end-1), x); */
/*   if (a == x) { */
/*       printf("the element is found !\n"); */
/*   }else { */
/*       printf("the element is not found !\n"); */
/*   } */
/*   return 0; */
/* } */


/////////////////////////////////////////////////////////////////
#include <stdio.h>
int isinarray(int **p, int *start, int *end, int x){
  if (*p == NULL) {
    return 0;
  }
  if (x < *start || x > *end) {
    return 0;
  }

  if (x == *start || x == *end) {
    return 1;
  }

  int i = 0;
  for (int *temp = *p; *temp != *end; temp++) {
    i++;
  }
  if (i == 1 && (x != *start || x != *end)) {
    return 0;
  }

  int medium = *(*p+i/2);
  if (medium >= x) {
    return isinarray(p, start, &medium, x);
  }else {
    int *m = *p+i/2;
    return isinarray(&m, &medium, end , x);
  }
}


int main(int argc, char *argv[])
{
  int list [] = {1,3,6,9,12,34,56,78,90,123,456,789};
  int *p = list;
  int x = 34;
  if (isinarray(&p, list, (int *)(&list+1)-1, x)) {
    printf("IN");
  }else {
    printf("NOT IN");
  }
  return 0;
}
