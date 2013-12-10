#include<stdio.h>

int main()
{
    int year;
    scanf("%d",&year);
    if((year%4==0 && year%100!=0)||(year%400==0))
        printf("%d is leap year\n",year);
    else
        printf("%d is not leap year\n", year);
    return 0;


  
}
// a=2 b=-4 c=2
