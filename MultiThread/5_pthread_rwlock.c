#include "apue.h"
int num;
pthread_rwlock_t rwlock;

void * thread_fun1(void *arg){
  int err;
  sleep(1);
  pthread_rwlock_wrlock(&rwlock);  // write mode lock
  // pthread_rwlock_rdlock(&rwlock);   // read mode lock

  printf("thread 1 print num as %d\n",num );
  sleep(5);
  printf("thread 1 is over \n");

  pthread_rwlock_unlock(&rwlock);
  return (void *)0;
}

void * thread_fun2(void *arg){
  int err;
  pthread_rwlock_wrlock(&rwlock);
  //  pthread_rwlock_rdlock(&rwlock);
  
  printf("thread 2 print num as %d\n",num );
  sleep(5);
  printf("thread 2 is over \n");
  
  pthread_rwlock_unlock(&rwlock);
  return (void *)0;
}

int main( )
{
  pthread_t tid1, tid2;
  int err;
  
  err = pthread_rwlock_init(&rwlock, NULL);
  if (err) {
    printf("init failed\n");
    return 0;
  }
  
  err = pthread_create(&tid1, NULL ,thread_fun1, NULL);
  if (err) {
    printf("create of the first thread fail\n");
    return 0;
  }

  err = pthread_create(&tid2, NULL ,thread_fun2, NULL);
  if (err) {
    printf("create of the second thread failed\n");
    return 0;
  }

  pthread_join(tid1, NULL);
  pthread_join(tid2, NULL);

  pthread_rwlock_destroy(&rwlock);
  
  return 0;
}



