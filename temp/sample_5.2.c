#include<stdio.h>

int main()
{
    for(int n=100;n<=200;n++)
        if(n%3!=0) printf("%2d ",n);
    printf("\n");

    return 0;
}

