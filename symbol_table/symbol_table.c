#include "symbol_table.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
extern int lines;
void InitializeNewNode(Node *NewNode, char *nameArg, char *type, int scope, int value);
int IsPresent(char *identifier, int scope, SymbolTable *symbolTable);

int InsertIdentifier(char *identifier, char *type, int scope, int value, SymbolTable *symbolTable);
int LookUpSymbolTable(char *nameArg, int scope, SymbolTable *symbolTable);
void PrintSymbolTable(int scope, SymbolTable *symbolTable);
void RemoveSymbolScope(int scope_to_remove, SymbolTable *symbolTable);
void UpdateSymbolTable(char *nameArg, int scope, int value, SymbolTable *symbolTable);

void InitializeNewNode(Node *NewNode, char *nameArg, char *type, int scope, int value)
{
	strcpy(NewNode->name, nameArg);
	strcpy(NewNode->type, type);
	NewNode->scope = scope;
	NewNode->value = value;
	NewNode->lines = lines;
	NewNode->nextNode = NULL;
	return;
}

int IsPresent(char *identifier, int scope, SymbolTable *symbolTable)
{
	Node *traverse = symbolTable->head;
	while (traverse != NULL)
	{
		if (strcmp(identifier, traverse->name) == 0 && traverse->scope == scope)
			return 1;
		traverse = traverse->nextNode;
	}
	return 0;
}

int InsertIdentifier(char *identifier, char *type, int scope, int value, SymbolTable *symbolTable)
{
	if (IsPresent(identifier, scope, symbolTable))
	{
		printf("ERROR:%d:Variable already declared\n", lines);
		return 0;
	}
	Node *newNode = (Node *)malloc(sizeof(Node));
	InitializeNewNode(newNode, identifier, type, scope, value);
	Node *traverse = symbolTable->head;
	if (traverse == NULL)
	{
		symbolTable->head = newNode;
		return 1;
	}
	while (traverse->nextNode != NULL)
		traverse = traverse->nextNode;
	traverse->nextNode = newNode;
	return 1;
}

int LookUpSymbolTable(char *nameArg, int scope, SymbolTable *symbolTable)
{
	if (symbolTable == NULL || symbolTable->head == NULL)
	{
		printf("ERROR:%d:Undeclared Variable\n", lines);
	}
	Node *temp = symbolTable->head;
	while (scope > 0)
	{
		Node *temp = symbolTable->head;
		while (temp != NULL)
		{
			if (strcmp(nameArg, temp->name) == 0 && temp->scope == scope)
				return temp->value;
			temp = temp->nextNode;
		}
		--scope;
	}
	printf("ERROR Here:%d:Undeclared Variable\n", lines);
	return -1;
}

void PrintSymbolTable(int scope, SymbolTable *symbolTable)
{
	if (symbolTable == NULL || symbolTable->head == NULL)
		return;
	Node *temp = symbolTable->head;
	while (temp != NULL)
	{
		if (temp->scope == scope)
			printf("|%s\t\t|%s\t\t|%d\t|%d\t|%d\t\t|\n", temp->name, temp->type, temp->scope, temp->value, temp->lines + 1);
		temp = temp->nextNode;
	}
	return;
}

void RemoveSymbolScope(int scope_to_remove, SymbolTable *symbolTable)
{
	if (symbolTable == NULL || symbolTable->head == NULL)
	{
		return;
	}

	Node *temp = symbolTable->head;

	while (temp != NULL && temp->scope == scope_to_remove)
		temp = temp->nextNode;
	symbolTable->head = temp;

	if (temp == NULL)
		return;

	Node *prev = NULL;
	while (temp != NULL && temp->nextNode != NULL)
	{
		prev = temp;
		temp = temp->nextNode;

		if (temp->scope == scope_to_remove)
		{
			prev->nextNode = temp->nextNode;
			temp->nextNode = NULL;
			temp = prev->nextNode;
		}
	}
}

void UpdateSymbolTable(char *nameArg, int scope, int value, SymbolTable *symbolTable)
{
	if (symbolTable == NULL || symbolTable->head == NULL)
	{
		return;
	}
	while (scope > 0)
	{
		Node *temp = symbolTable->head;
		while (temp != NULL)
		{
			if (strcmp(temp->name, nameArg) == 0 && temp->scope == scope)
			{
				temp->value = value;
				return;
			}
			temp = temp->nextNode;
		}
		--scope;
	}
	printf("ERROR:%d:Undeclared Variable\n", lines);
	return;
}