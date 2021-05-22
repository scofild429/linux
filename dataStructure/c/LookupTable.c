#include <stdio.h>
#include <stdlib.h>
#define  KeyType int
typedef struct{
  KeyType key;
}ElemType;

typedef struct{
  ElemType *elem;
  int length;
}SSTable;

void create(SSTable ** table, int *context , int length){
  (*table)=(SSTable*)malloc(sizeof(SSTable));
  (*table)->length = length;
  (*table)->elem = (ElemType*)malloc((length+1)*sizeof(ElemType));
  for (int i =1; i <= length; i++) {
    (*table)->elem[i].key = *(context+i-1);
  }
}

int search(SSTable *table, int lookup){
  table->elem[0].key = lookup;
  int i = table->length;
  while (table->elem[i].key != table->elem[0].key) {
    i--;
  }
  return i;
}

int search_binary(SSTable *table, int lookup){
  int low = 1;
  int high = table->length;
  int mid;
  while (low <= high) {
     mid = (low + high)/2;
     if(table->elem[mid].key == lookup){
       return table->elem[mid].key;
     }else if (table->elem[mid].key > lookup) {
       high = mid-1;
     }else {
       low = mid+1;
     }
  }
  return 0;
}


int main(int argc, char *argv[])
{
  int context[] = {1, 3, 7, 23, 56, 89, 345};
  int length =  sizeof(context)/sizeof(int);
  SSTable *table;
  create(&table, context, length);
  int lookup = 7;
  int localation = search(table, lookup);
  if (localation) {
    printf("In\n");
  }else {
    printf("NOT In\n");
  }
  
  int localation_binary = search_binary(table, lookup);
  if (localation_binary) {
    printf("at postion : %d", localation);
  }else {
    printf("is not here");
  }
  return 0;
}
