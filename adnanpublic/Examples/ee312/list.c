#include <stdio.h>
#include <stdlib.h>

struct node {
  int data;
  struct node *next;
};

struct node* new_node(int data, struct node *next) {
  struct node *result = (struct node *) malloc( sizeof( struct node ));
  result->data = data;
  result->next = next;
  return result;
}

struct list {
  struct node *head;
  struct node *tail;
  int size;
};

struct list* new_list() {
  struct list *result = 
      (struct list *) malloc( sizeof( struct list ) );
  result->size = 0;
  result->head = NULL;
  result->tail = NULL;
  return result;
}

void insert_head( struct list * l, int value ) {
  struct node *n = new_node( value, l->head );
  l->head = n;
  if ( l->tail == NULL ) {
    l->tail = n;
  }
  l->size++;
}

void insert_tail( struct list * l, int value ) {
  struct node *n = new_node( value, NULL );
  if ( l->tail != NULL) {
    l->tail->next = n;
  } else {
    l->head = n;
  }
  l->tail = n;
  l->size++;
}

void print_list( struct list *l) {
   struct node *p = l->head;
   printf("head = %d\ttail = %d; ", (l->head != NULL) ? l->head->data : -1, 
       (l->tail != NULL) ? l->tail->data : -1);
   while (p) {
     printf("%d ", p->data);
     p = p->next;
   }
   printf("\n");
}

int delete( struct list *l, int key) {
  if ( l->head == NULL ) {
    return 0;
  }
  if (l->head->data == key ) {
    if ( l->tail == l->head ) {
       free(l->head);
       l->head = l->tail = NULL;
       l->size--;
       return 1;
    }
    struct node *tmp = l->head;
    l->head = l->head->next;
    free(tmp);
    l->size--;
    return 1;
  }
  struct node *t1;
  struct node *t2;
  t2 = l->head;
  t1 = l->head->next;
  while ( t1 != NULL ) {
    if (t1->data == key) {
      t2->next = t1->next;
      if ( t1 == l->tail ) {
        l->tail = t2;
      }
      free(t1);
      l->size--;
      return 1;
    }
    t2 = t1;
    t1 = t1->next;
  }
  return 0;
}

int main(void) {
  struct list *l = new_list();
  insert_head(l, 1);
  insert_head(l, 2);
  insert_tail(l, 3);
  print_list(l);
  delete(l, 1);
  print_list(l);
  insert_head(l, 0);
  print_list(l);
  delete(l, 3);
  print_list(l);
  delete(l, 4);
  delete(l, 0);
  delete(l, 2);
  print_list(l);
  return 0;
}
