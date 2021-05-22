#include <stdio.h>
#include <string.h>
#include <stdlib.h>

//sort only the pure given numbers, and change each time the sort direction
int recSort(int *start, int *end, int reverse){
  int count = 0;
  
  if (start == NULL || end == NULL) {
    return 0;
  }

  if (start == end || start +1 == end) {
    return 0;
  }

  
  int* p;
  if (reverse) 
    p = end -1;
  else
    p = start+1;

  
  while (p < end && p > start ) {
    if (*(p-1) < *p) {
      int temp = *(p-1);
      *(p-1) = *p;
      *p = temp;
      count++;
    }

    if (reverse)
      p--;
    else
      p++;
  }

  if (reverse)
    return count +  recSort(start+1, end, 0);
  else
    return count +  recSort(start, end-1, 1);
    
}


int main(int argc, char *argv[]) {

  if (argc < 1) {
    recSort(NULL, NULL, 0);
    return -2;
  }
  
  int* f = malloc(sizeof(int) * (argc-1));
  if (f == NULL) {
    return -3;
  }
  
  for (int i = 1; i < argc; i++) {
    f[i-1] =atoi(argv[i]);
  }

  printf("before the sort \n");
  for (int i =1 ; i < argc; i++) {
    printf("%d\n",f[i-1]);
  }

  int i=  recSort(f, &f[argc-1] , 0);
  printf("alles in allem, %d times change  \n",i);
  
  printf("after the sort \n");
  for (int i =1 ; i < argc; i++) {
    printf("%d\n",f[i-1]);
 }

   
  free(f);
  return 0;
}
