#include<stdio.h>

int main()
{
    int score;
    scanf("%d",&score);
    if (score >= 60 && score < 70)
        printf("the score is grade C\n");   
    else
        printf("not C\n");


    return 0;
}

