#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef struct {
  int data;
  int parent, lboy, rboy;
}HTNode, *HoffmanTree;
typedef char ** HoffmanCode;
void Select(HoffmanTree HT, int *s1, int *s2, int end){
  int min1, min2;
  int i = 1;
  while (HT[i].parent != 0 && i <= end) {
    i++;
  }
  min1 =  HT[i].data;
  *s1 = i;
  i++;
  while (HT[i].parent != 0 && i <= end) {
    i++;
  }
  if (HT[i].data <= min1) {
    min2 = min1;
    *s2 = *s1;
    min1 = HT[i].data;
    *s1 = i;
  }else {
    min2 = HT[i].data;
    *s2 = i;
  }
  for (int j = i+1; j <= end; j++) {
    if (HT[j].parent != 0) {
      continue;
    }
    if (HT[j].data <= min1) {
      min2 = min1;
      *s2 = *s1;
      min1 = HT[j].data;
      *s1 = j;
    }else {
      min1 = HT[j].data;
      *s2 = j;
    }
  }
}


void CreateHoffman(HoffmanTree *HT, int *list, int length){
  if (length <= 1) {
    return;
  }
  int m = 2*length-1;
  *HT = (HoffmanTree)malloc(sizeof(HTNode) * m);
  int i;
  for (i = 1; i <= length; i++) {
    (*HT+i)->data = *(list+i-1);
    (*HT+i)->parent = 0;
    (*HT+i)->lboy = 0;
    (*HT+i)->rboy = 0;
  }
  for (i = length+1; i <= m; i++) {
    (*HT+i)->data = 0;
    (*HT+i)->parent = 0;
    (*HT+i)->lboy = 0;
    (*HT+i)->rboy = 0;
  }
  
  for (i = length+1; i <=m; i++) {
      int s1, s2;
      Select(*HT, &s1, &s2, i-1);
      (*HT)[s1].parent = (*HT)[s2].parent = i;
      (*HT)[i].lboy = s1;
      (*HT)[i].rboy = s2;
      (*HT)[i].data = (*HT)[s1].data + (*HT)[s2].data;
  }
}

void CreateHoffmanCode(HoffmanCode *hcode, HoffmanTree HT, int length){
  *hcode = (HoffmanCode)malloc(sizeof(char * ) * length+1);
  char *cd = (char *)malloc(sizeof(char) * length);
  cd[length-1] = '\n';
  for (int i  = 1; i <= length; i++) {
    int start = length -1;
    int c = i;
    int j = HT[c].parent;
    while (j != 0) {
      if (HT[j].lboy == c) {
	cd[--start] = '1';
      }
      else {
	cd[--start] = '0';
      }
      c = j;
      j = HT[j].parent;
    }
    (*hcode)[i] = (char *)malloc(sizeof(char )*length-start);
    strcpy((*hcode)[i], &cd[start]);
  }
  free(cd);
}
void showHoffmanCode(HoffmanCode hcode, int *list, int length){
  printf("Here we go\n");
  for (int i = 1; i <= length; i++) {
    printf("%d : is %s\n",list[i-1], hcode[i]);
  }
}

int main(int argc, char *argv[])
{
  HoffmanTree htree;
  HoffmanCode hcode;
  int list[] = {1,18,2,56,3,4, 44,5,7,34,78,90,234,789};
  int length = sizeof(list)/sizeof(int);
  CreateHoffman(&htree, list, length);
  CreateHoffmanCode(&hcode, htree, length);
  showHoffmanCode(hcode, list, length);
  return 0;
}

