#include <stdio.h>
#include <stdlib.h>
#define N 10
typedef struct node {
  struct node * Nnode;
  struct node * Pnode;
  int data;
}node;
  
node *initDoubleRecycleVerketteList(int x){
  node * head = (node *)malloc(sizeof(node));
  head->data = 1;
  head->Nnode = NULL;
  head->Pnode = NULL;
  node * temp = head;
  for (int i = 2; i <=x; i++){
    node * a = (node *)malloc(sizeof(node));
    a->data = i;
    a->Nnode = NULL;
    a->Pnode = NULL;

    temp->Nnode = a;
    a->Pnode = temp;
    temp = temp->Nnode;
  }
  temp->Nnode = head;
  head->Pnode = temp;
  return head;
}

void display(node *p){
  node *temp = p;
  if (p != NULL) {
    do{
      printf("%d ", temp->data);
      temp = temp->Nnode;
    } while (temp != p);
  }else {
    printf("the list is empty\n");
  }
}  

int main(int argc, char *argv[])
{
  node * head = initDoubleRecycleVerketteList(N);
  display(head);
  return 0;
}
