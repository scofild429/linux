#include <stdio.h>
#define Maxsize 10

typedef struct {
  int nextpos;
  int data;
} component;

void reserveArray (component *array){
  for (int i=0; i < Maxsize; i++) {
    array[i].nextpos = i+1;
    array[i].data = -1;
  }
  array[Maxsize-1].nextpos = 0;
}

int Mallocpos(component *array){
  int i = array[0].nextpos;
  if (i){
    array[0].nextpos = array[i].nextpos;
  }
  return i;
}
	      

int initArray(component * array){
  int Liststart = Mallocpos(array);
  int temp = Liststart;
  for (int i = 1; i < 4; ++i) {
    int reserveArrayfree = Mallocpos(array);
    array[temp].nextpos = reserveArrayfree;
    array[reserveArrayfree].data = i;
    temp = reserveArrayfree;
  }
  array[temp].nextpos = 0;
  return Liststart;
}

void displayArr(component *array, int p){
  int temp = p;
  while(array[temp].nextpos){
    printf(" the %d elements of StaticVerketteList elements is %d\n",array[temp].nextpos, array[temp].data );
    temp = array[temp].nextpos;
  }
  printf(" the %d elements of StaticVerketteList elements is %d\n",array[temp].nextpos, array[temp].data );

}

int main(int argc, char *argv[])
{
  component array[Maxsize];
  reserveArray(array);
  int p = initArray(array);
  displayArr(array, p);
  return 0;
}
