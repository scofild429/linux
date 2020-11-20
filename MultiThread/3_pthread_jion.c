#include "apue.h"

void *thread_fun1(void *arg){
  printf("New thread out with return\n");
  return (void *)1;
}

void *thread_fun2(void *arg){
  printf("New thread out with pthread_exit\n");
  pthread_detach(pthread_self()); // detach it self
  pthread_exit((void *)2);
}


int main( )
{
  pthread_t tid1, tid2;
  int err1, err2;
  void  *reval1, *reval2;

  err1 = pthread_create(&tid1, NULL, thread_fun1, NULL); 
  err2 = pthread_create(&tid2, NULL, thread_fun2, NULL); 

  if (err1 || err2) {
    printf("The create of new thread is failed\n");
  }

  printf("the thread 1 has return as %d\n", pthread_join(tid1, &reval1) );
  printf("the thread 2 has return as %d\n", pthread_join(tid2, &reval2) );

  printf("the thread 1 has return code %d\n",(int*)reval1 );
  printf("the thread 2 has return code %d\n",(int*)reval2 );
  
  return 0;
}

  
