#ifndef SYMBOL_H
#define SYMBOL_H
#include <stdlib.h>
#include <string.h>
typedef struct Node_T
{
	char name[30];
	char type[30];
	int  scope;
	int  value;
	int  lines;
	struct Node_T* nextNode;
}Node;

struct SymbolTable_T
{
    Node* head;
};

typedef struct SymbolTable_T SymbolTable;

int 	InsertIdentifier(char* identifier,char* type,int scope,int value,SymbolTable* symbolTable);
int 	LookUpSymbolTable(char* nameArg,int scope,SymbolTable* symbolTable);
void 	PrintSymbolTable(int scope_to_remove,SymbolTable* symbolTable);
void 	RemoveSymbolScope(int scope_to_remove,SymbolTable* symbolTable);
void 	UpdateSymbolTable(char* nameArg,int scope,int value,SymbolTable* symbolTable);

#endif
