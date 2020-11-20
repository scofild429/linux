#include "apue.h"

pthread_attr_t attr;

void *thread_fun(void *arg){

  size_t stacksize;

#ifdef _POSIX_THREAD_ATTR_STACKSIZE
  pthread_attr_getstacksize(&attr, &stacksize);
  printf("new thread stack size is %d \n", (int)stacksize );  //获取默认栈大小
  //更改 has to be greater than 16384, otherwise will be default
  pthread_attr_setstacksize(&attr, 100000);
  pthread_attr_getstacksize(&attr, &stacksize);
  printf("new thread stack size is %d \n", (int)stacksize );  //获取设置栈大小
#endif // _POSIX_THREAD_ATTR_STACKSIZE
  

  return (void *)1;
}


int main(int argc, char *argv[])
{
  pthread_t tid;
  int err;

  pthread_attr_init(&attr);

  //设置为可连接的分离属性
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

  //check if system support this
#ifdef _POSIX_THREAD_ATTR_STACKSIZE
    pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN);
#endif // _POSIX_THREAD_ATTR_STACKSIZE

  err = pthread_create(&tid, &attr, thread_fun, NULL);
  if (err) {
    printf("create new thread failed \n");
    return 0;
  }
  pthread_join(tid ,NULL);
  return 0;
}
