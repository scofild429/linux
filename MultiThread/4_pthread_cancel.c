#include "apue.h"

void *thread_fun(void * arg){
  int stateval;
  int typeval;

  //  set cancel to be disable
  stateval = pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
  if (stateval != 0) {
    printf("set cancel state to disable is failed\n");
  }
  printf("I'm New thread here !\n");
  sleep(4);


  //set cancel to be enable, will be canceled at the first cancel point
  stateval = pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
  if (stateval != 0)
    printf("set cancel state to enable is failed\n");
  else
    printf("about to set cancel enable\n");   // print is a cancel point

  //set cancel to be enable and immediately
  typeval = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
  if (typeval != 0) {
    printf("set cancel state to immediately failed\n");
  }

  //cancel points
  printf("first place to cancel:\n");
  printf("second place to cancel:\n");
  return (void *)20;
}



int main( )
{
  pthread_t tid;
  int err, cval, jval;
  void * rval;

  err = pthread_create(&tid, NULL, thread_fun, NULL);
  if (err != 0) {
    printf("creat new thread is failed\n");
    return 0;
  }
  sleep(2);

  cval = pthread_cancel(tid);
  if (cval != 0) {
    printf("cancel the new thread is failed\n");
    return 0;
  }
  
  jval = pthread_join(tid, &rval);
  if (jval != 0) {
    printf("join thread  is failed\n");
    return 0;
  }
  printf("new thread has return code of %d\n", (int) rval );
    
  return 0;
}
