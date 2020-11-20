#include "apue.h"

void print_id(char *s)
{
  pid_t pid;
  pthread_t tid;
  
  pid = getpid();
  tid = pthread_self();

  printf("%s pid is %u, and tid is 0x%x\n", s, pid, (int) tid);
}

void *thread_fun(void *arg)
{
  printf("In son thread, can't get the father tid \n");
        
  print_id(arg);
  return (void *)0;
}

int main( )
{
  pthread_t ntid;
  int err;
  err = pthread_create(&ntid, NULL, thread_fun, "new thread");
  
  if (err != 0) {
    printf("create new thread is failed\n");
    return 0;
  }
  printf("In father thread, the new THREAS is 0x%x \n", (int)ntid );
  
  print_id("main thread");
  sleep(2);
  
  return 0;
}

