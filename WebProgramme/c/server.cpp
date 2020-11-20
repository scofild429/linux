#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <netinet/in.h>

// 在服务端，是用bind 和listen函数，
// 有socket函数生成的serv_sock套接字，
// 还有利用函数accept 和serv_sock生成的clnt_sock套接字。
// 注意： 在相互通信时，利用clnt_sock可以读也可以写。

// 而在客户端，是用connect函数，
// 只有利用socket函数生成的sock套接字，
// 同时可以读可以写

// 在字符串读写时，读出时不知其大小，用整个长度，写入时可用strlen()函数



int main(){

  int serv_sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
  struct sockaddr_in serv_addr;
  memset(&serv_addr, 0, sizeof(serv_addr));
  serv_addr.sin_family = AF_INET; 
  serv_addr.sin_addr.s_addr = inet_addr("127.0.0.1"); 
  serv_addr.sin_port = htons(1234); 

  bind(serv_sock, (struct sockaddr*)&serv_addr, sizeof(serv_addr));
  listen(serv_sock, 20);


  struct sockaddr_in clnt_addr;
  socklen_t clnt_addr_size = sizeof(clnt_addr);
  int clnt_sock = accept(serv_sock, (struct sockaddr*)&clnt_addr, &clnt_addr_size);


  //只有服务器发给用户一条信息
  // char str[] = "http://c.biancheng.net/socket/";
  // write(clnt_sock, str, sizeof(str));
  // close(clnt_sock);
  // close(serv_sock);


  // 一次由用户发给服务器再回传
  // char buffer[40];
  // read(clnt_sock, buffer, 40);
  // write(clnt_sock, buffer, strlen(buffer));
  // close(clnt_sock);
  // close(serv_sock);


  // // 五次发送回传
  // char buffer[40];
  // memset(buffer, 0, 40);
  // int i = 0;
  // while (i<5) {
  //   int clnt_sock1 = accept(serv_sock, (struct sockaddr*)&clnt_addr, &clnt_addr_size);
  //   read(clnt_sock1, buffer, 40);
  //   printf("%s\n", buffer);
  //   write(clnt_sock1, buffer, strlen(buffer));
  //   close(clnt_sock1);
  //   memset(buffer, 0, 40);
  //   i++;
  // }
  // close(serv_sock);


  //传送文件
  //abc.org 必须存在
  FILE *fp = fopen("./abc.stoket", "rb");
  if( fp == NULL){
      printf("Fail to open the file");
      exit(0);
    }
  int cCount;
  char buffer[40];
  memset(buffer, 0, 40);
  while( (cCount = fread(buffer, 1, 40, fp)) > 0){
    write(clnt_sock,buffer,cCount);
  }
  shutdown(clnt_sock, SHUT_RD);
  read(clnt_sock, buffer, 40);
  fclose(fp);
  close(clnt_sock);
  close(serv_sock);
    

  return 0;
}
