#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void genertarray(char pattern[], int prefix[], int n){
  prefix[0] = 0;
  int len = 0;
  int i =1;
  while (i < n) {
    if (pattern[i] == pattern[len]) {
      len++;
      prefix[i] = len;
      i++;
    }else {
      if (len > 0) {
	len = prefix[len-1];   //go the preious len, and matching again
      }else {
	prefix[i] = len;        // in case len <= 0, bzw, the first and second is not matching
	i++;
      }
    }
  }
}

void move_array(int prefix [], int n){
  int i;
  for ( i = n-1; i > 0; i--) {
    prefix[i] = prefix[i-1];
  }
  prefix[0] = -1;
}

void kmp_search(char text[], char pattern[]){
  int k = strlen(pattern);
  int* prefix =(int *) (malloc(sizeof(int )* k));
  genertarray(pattern, prefix, k);
  move_array(prefix, k);

  // text    index i, max n
  // pattern index j, max m

  int i = 0; int j = 0;
  int n = strlen(text);
  int m = strlen(pattern);
  while (i < n) {
    if (j == m-1 && text[i] == pattern[j]) { // if found
      printf("Fonund at %d \n", i-j);
      j = prefix[j];                         // still go forward
    }
    if (text[i] == pattern[j]) {            
      i++;j++;
    }else {
      j = prefix[j];                        //if not matching
      if (j == -1) {                        //if the first is not matching
	i++;j++;
      }
    }
  }
}

int main(int argc, char *argv[])
{
  char pattern[] = "ABABBBA"; 
  char text[]    = "JUHkSABABBBABABA";
  kmp_search(text, pattern);
  return 0;
}

