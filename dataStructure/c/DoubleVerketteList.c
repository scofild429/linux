#include <stdio.h>
#include <stdlib.h>
#define N 10

typedef struct node{
  struct node* pronode;
  int data;
  struct node *nextnode;
}node;

node *initnode( node *p){
  p = (node *)malloc(sizeof(node));
  p->pronode = NULL;
  p->nextnode = NULL;
  p->data = 1;
  node *temp = p;
  for (int i = 1; i < N; ++i) {
    node *a =(node *)malloc(sizeof(node));
    a->nextnode = NULL;
    a->pronode = NULL;
    a->data = i+1;
    temp->nextnode = a;
    a->pronode = temp;
    temp = temp->nextnode;
  }
  return p;
}

void display(node *p){
  node *temp = p;
  while (temp) {
    while (temp->nextnode) {
      printf("%d ",temp->data );
      temp = temp->nextnode;
    }
    printf(", and  the last is %d\n",temp->data );
    temp = temp->nextnode;
  }
}

void insert(node *p, int x, int pos){
  node *a =(node *)malloc(sizeof(node));
  a->data = x;
  a->nextnode = NULL;
  a->pronode = NULL;
  if (x == 1) {
    a->nextnode = p;
    p->pronode = a;
    p = a;
  }else {
    node *temp = p;
    for (int i = 1; i < pos-1; i++) {
      temp = temp->nextnode;
    }
    if (temp->nextnode == NULL) {
      temp->nextnode = a;
      a->pronode = temp;
    }else {
      a->nextnode = temp->nextnode;
      temp->nextnode = a;
      a->pronode = temp;
      a->nextnode->pronode = a;   
      /* temp->nextnode->pronode = a; */  // this line do the same as last one, why???
      printf("%s\n", "nihao");
    }
  }
}

node *delete(node *p, int x){
  node *temp = p;  
  if (p->data == x) {
    p = p->nextnode;
    free(temp);
    return p;
  }

  while (temp->nextnode->nextnode != NULL && temp->nextnode->data != x) {
    temp = temp->nextnode;
  }
  if (temp->nextnode->nextnode == NULL) { // check if it is the last element
    if (temp->nextnode->data == x) {      // check if it is what we want 
      temp->nextnode = NULL;
      free(temp->nextnode);
      return p;
    }else {
      printf("there is no element of %d\n", x);
      return p;
    }
  }else {
    temp->nextnode = temp->nextnode->nextnode;
    temp->nextnode->pronode= temp;
    return p;
  }
}

int main(int argc, char *argv[])
{
  node *head = NULL;
  head = initnode(head);
  display(head);
  insert(head, 100, 6);
  display(head);
  delete(head, 100);
  display(head);
  /* 1, if only one elemenet in list */
  /* 2, execute : temp->nextnode->nextnode != NULL && temp->nextnode->data != x */
  /* 3, if while stop, check if temp->nextnode is the last element */
  /* 4, if temp->nextnode is what we want */
  node * p = delete(head, 2);
  display(p);
  return 0;
}

