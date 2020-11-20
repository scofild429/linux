/* 带头节点 */
/* 建（创建C1） */
/* 查（ 全查R1,  靠值查R2,   靠位查R3 ） */
/* 改 (         靠值改U1，  靠位改U2） */
/* 增（头插A1， 尾插A2，中值插A3， 中位插A4) */
/* 删（头删D1， 尾删D2，中值删D3， 中位删D4) */

#include <stdio.h>
#include <stdlib.h>

typedef struct Link{
  int elem;
  struct Link *next;
}link;

link *initLinkC1(int j){
  link *p = (link *)malloc(sizeof(link));
  link *temp = p;
  int i;
  for (i=1; i <= j; i++) {
    link *a = (link *)malloc(sizeof(link));
    a->elem = i;
    a->next = NULL;
    temp->next = a;
    temp = temp->next;
  }
  return p;
}

void displayR1(link *p){
  link *temp = p;
  while(temp->next){
    printf("%d ",temp->next->elem);
    temp = temp->next;
  }
  printf("\n");
}

int displayR2(link *p, int k){
  link *temp = p;
  while (temp->next) {
    if (temp->next->elem == k) {
      return temp->next->elem;
    }
    temp = temp->next;
  }
  if (temp->next == NULL) {
    printf("the %d is not found \n", k);
  }
  return k;
}

int displayR3(link *p, int k){
  link *temp = p;
  int i = 0;
  while (i < k && temp->next) {
    temp = temp->next;
    i++;
  }
  if (i != k) {
    printf("the %d postion element is not found\n",k );
    return -1;
  }
  return temp->elem;
}

void changeelementU1(link *p, int i, int k){
  link *temp = p;
  while (temp->next != NULL){
    if (temp->elem == i){
      break;
    }
    temp = temp->next;
  }

  if (temp->next == NULL) {   // if temp is the last element,
    if (temp->elem != i) {    // if the last element is not what we want
      printf("there is no element which contains %d\n",i );
    }else {
      temp->elem = k;        // if the last one is what we want
    }
  }else {
    temp->elem = k;          // if temp is not the last one
  }
}

void changeelementU2(link *p, int i, int k){
  link *temp = p;
  int m = 0;
  while (m < i && temp->next != NULL){
    temp = temp->next;
    m++;
  }
  if (m != i) {             // if the length of list is shorter than given i
    printf("the %d postion element is not found\n",i );    
  }else {
    temp->elem = k;
  }
}

void addelementA1(link *p, int k){
  link *a = (link *)malloc(sizeof(link));
  a->elem = k;
  a->next = p->next;
  p->next = a;
}

void addelementA2(link *p, int k){
  link *temp = p;
  while (temp->next->next != NULL) {
    temp = temp->next;
  }
  link *a = (link *)malloc(sizeof(link));
  a->elem = k;
  a->next = NULL;
  temp->next->next = a;
}

void addelementA3(link *p, int i, int k){
  link *temp = p;
  while (temp->next != NULL) {
    if (temp->next->elem == i) {
      break;
    }
    temp = temp->next;
  }
  if (temp->next == NULL) {    // if temp is the last element
    if (temp->elem != i) {     // if the last element is not what we want :temp->elem != k
      printf("there is no element which contains %d\n",k );
    }else {                     // if the last element is what we want: temp->elem == k
      link *a = (link *)malloc(sizeof(link));
      a->elem = k;
      a->next = NULL;
      temp->next = a;
    }
  }else {                       // if temp->next->elem == k
    link *a = (link *)malloc(sizeof(link));
    a->elem = k;
    a->next = NULL;
    /* add the element behind i */
    a->next = temp->next->next;
    temp->next->next = a;
    /* add the element front of i */
    /* a->next = temp->next; */
    /* temp->next = a; */
  }
}

void addelementA4(link *p, int i, int k){
  link *temp = p;
  int m = 0;
  while (m < i && temp->next != NULL) {
    temp = temp->next;
    m++;
  }
  if (m != i) {                    // the length of list is shorter than i
      printf("the %d postion element is not found\n",i);
  }else if(!temp->next) {            // if temp is the last element of list      
      link *a = (link *)malloc(sizeof(link));
      a->elem = k;
      a->next = NULL;
      temp->next = a;
  }else {                           // if temp is not the element of list
    link *a = (link *)malloc(sizeof(link));
    a->elem = k;
    a->next = NULL;
    a->next = temp->next->next;
    temp->next->next = a;
    /* add the element front of i */
    /* a->next = temp->next; */
    /* temp->next = a; */
  }
}

void deleteelementD1(link *p){
  p->next = p->next->next;
}

void deleteelementD2(link *p){
  link *temp = p;
  while(temp->next->next){
    temp = temp->next;
  }
  temp->next = NULL;
  free(temp->next);
}

void deleteelementD3(link *p, int k){
  link *temp = p;
  while (temp->next->next != NULL){
    if (temp->next->elem == k){
      break;
    }
    temp = temp->next;
  }
  if (temp->next->next == NULL) {      // if temp->next is the last element
    if(temp->next->elem != k) {         // temp->next is the last, but it's not what we want
      printf("there is no element which contains %d\n",k );
    }else{                               // temp->next is the last, but is what we want
      temp->next = NULL;
      free(temp->next);
    }
  }else{                               // temp->next is not the last, so it must be what we look for
    temp->next = temp->next->next;
  }
}

void deleteelementD4(link *p, int k){
  link *temp = p;
  if (k == 1) {
    if (temp->next->next == NULL) {   // only one element auf dem List
      temp->next = NULL;
      free(temp->next);
      return;
    }else {
      temp->next = temp->next->next;
      return;
    }
  }
  // if k >=  2 and there are more than or equal 2 elements in list
  int m = 0;             
  while (m < k-1 && temp->next->next != NULL){
    temp = temp->next;
    m++;
  }
  if (m != k-1) {                              // list is shorter than k
    printf("the %d postion element is not found\n",k);
  }else if(temp->next->next == NULL){            // if temp->next->next is the last element
    temp->next = NULL;
    free(temp->next);
  }else{                                        // if temp->next->next is not the last element
    temp->next = temp->next->next;
  }
}

link *reserve(link* p){
  link * begin = NULL;
  link * mid = p->next;
  link * end = p->next->next;
  while (end) {
    mid->next = begin;
    begin = mid;
    mid = end;
    end = end->next;
  }
  mid->next = begin;
  link *m =(link *)malloc(sizeof(link));
  m->next = mid;
  return m;
}

int main(int argc, char *argv[])
{
  /* 建（创建C1） */
  link *p = initLinkC1(9);
  printf("generate the list from 1 to 9 \n");
  /* 查（ 全查R1,  靠值查R2,   靠位查R3 ） */  
  displayR1(p);
  int r2 = 3;
  printf("check if we can find %d in the list, and  to be %d\n", r2, displayR2(p, r2));
  int r3 = 10;
  printf("check if we can find %d postion in the list, and to be %d\n", r3, displayR3(p, r3));
  /* 改 (         靠值改U1，  靠位改U2） */
  printf("change the element 9 to 10 \n");
  changeelementU1(p, 9, 10);
  displayR1(p);
  printf("change the postion 9 to 10 \n");
  changeelementU2(p, 9, 11);
  displayR1(p);
  /* 增（头插A1， 尾插A2，中值插A3， 中位插A4) */
  printf("add 0 to the begin of list \n");
  addelementA1(p, 0);
  displayR1(p);
  printf("add 20 to the end of list \n");
  addelementA2(p, 20);
  displayR1(p);
  printf("add 18 to the list behind element 2 \n");
  addelementA3(p, 2, 15);
  displayR1(p);
  printf("add 18 to the list behind  postion 2 \n");
  addelementA4(p, 1, 18);
  displayR1(p);
  /* 删（头删D1， 尾删D2，中值删D3， 中位删D4) */
  printf("delete the frist lement \n");
  deleteelementD1(p);
  displayR1(p); 
  printf("delete the the last element \n");
  deleteelementD2(p);
  displayR1(p);
  printf("delete the element 1 \n");
  deleteelementD3(p, 1);
  displayR1(p);
  printf("delete the postion 2 \n");
  deleteelementD4(p, 2);
  displayR1(p);
  /* reverse倒叙  */
  /* 1 去掉头节点 */
  /*   2 从第一个元素开始反转，并连接 */
  /*   3 到end = null 停止 */
  /*   4 连接最后一个元素 */
  /*   5 开辟新的头节点 */
  /*   6 连接头节点，并返回 */
  printf("reserve the list\n");
  link *m = reserve(p);
  displayR1(m);
  return 0;
}
