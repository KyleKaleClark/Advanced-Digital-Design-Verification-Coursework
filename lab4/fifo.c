#include <stdio.h>
#include <stdint.h>


#define FIFO_DEPTH 16

static int32_t fifo_array[FIFO_DEPTH];
static int w_ptr = 0;
static int r_ptr = 0;
static int full = 0;
static int empty = 0;
static int wlooped = 0;
static int rlooped = 0;

int get_r_ptr(){
  return r_ptr;
}

int get_w_ptr(){
  return w_ptr;
}

int push(int32_t data){
  if (is_full()){
    return 0;
  }
  
  fifo_array[w_ptr] = data;
  w_ptr = w_ptr + 1;

  if(w_ptr >= FIFO_DEPTH){
    w_ptr = 0;
    wlooped = !wlooped;
  }
  return 1;
}


int pop(){

  if (is_empty()){
    return 0;
  }
  
  int32_t popvalue  = fifo_array[r_ptr]; //write popvalue so we can inc r_ptr before returning
  r_ptr = r_ptr + 1
    ;
  if (r_ptr >= FIFO_DEPTH){
    r_ptr = 0;
    rlooped = !rlooped;
  }
  return popvalue;
}


int is_empty(){
  return (r_ptr == w_ptr) && (rlooped == wlooped);
}

int is_full(){
  return (r_ptr == w_ptr) && (rlooped != wlooped);
}


int rst_r_ptr(){
  r_ptr = 0;
  rlooped = 0;
  return 1;  
}
int rst_w_ptr(){
  w_ptr = 0;
  wlooped = 0;
  return 1;
}
