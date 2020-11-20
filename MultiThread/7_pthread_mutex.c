#include "apue.h"

struct student{
  int age;
  int size;
} stu;

int i;
pthread_mutex_t mutex;

void *thread_fun1(void *arg){
  while(1){
    //    pthread_mutex_lock(&mutex);
    stu.age = i;
    stu.size = i;
    i++;
    if (stu.age != stu.size) {
      printf("thread 1 %d, %d,\n", stu.age, stu.size);
      break;
    }
    //    pthread_mutex_unlock(&mutex);
  }
  return (void *)0;
}


void *thread_fun2(void *arg){
  while (1) {
    //    pthread_mutex_lock(&mutex);
    stu.age = i;
    stu.size = i;
    i++;
    if (stu.age != stu.size) {
      printf("thread 2 %d, %d,\n", stu.age, stu.size);
    }
    //    pthread_mutex_unlock(&mutex);
  }
  return(void *)0;
}

int main( )
{
  pthread_t tid1, tid2;
  int err1, err2;

  err1 = pthread_create(&tid1, NULL, thread_fun1, NULL);
  err2 = pthread_create(&tid2, NULL, thread_fun2, NULL);  
  if (err1 || err2) {
    printf("the create o pthread 1 and pthread 2 failed\n");
  }

  pthread_join(tid1, NULL);
  pthread_join(tid2, NULL);
    
  return 0;
}

