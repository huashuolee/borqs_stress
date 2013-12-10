#include<stdio.h>

int main()
{
    int grade;
    scanf("%d",&grade);
    printf("Your score:");
    switch(grade)
    {
     case 1 :printf("85~100\n");break;
     case 2:printf("70~84\n");break;
     case 3:printf("60~69\n");break;
     case 4:printf("<60\n");break;
     default:printf("error!\n");
    }


    return 0;
}

