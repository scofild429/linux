#include "apue.h"

void *thread_fun1(void *arg)
{
  printf("I am new thread  1\n");
  return (void *)1;
}


void *thread_fun2(void *arg)
{
  printf("I am new thread  2 \n");
  return (void *)2;
}

int main(int argc, char *argv[])
{
  pthread_t tid1, tid2;
  int err;

  //def attr and init and set to be spreate
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  //  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);  

  err = pthread_create(&tid1, &attr, thread_fun1, NULL);
  if (err) {
    printf("create new thread 1 failed \n");
    return 0;
  }
  
  err = pthread_create(&tid2, NULL, thread_fun2, NULL);
  if (err) {
    printf("create new thread 2 failed \n");
    return 0;
  }

  err = pthread_join(tid1, NULL);
  if (!err) 
    printf("join thread 1 success \n");
  else 
    printf("jion thread 1 failed \n");


  err = pthread_join(tid2, NULL);
  if (!err) 
    printf("join thread 2 success \n");
  else 
    printf("jion thread 2 failed \n");

  pthread_attr_destroy(&attr);
  
  return 0;
}

