#include<stdio.h>
int main()
{
    int s,x;
    printf("input 1 int:\n");
    s=sum(x);
    printf("the sum is %d\n",s);

}
int sum(int x)
{
   int sum1=0,i;
   scanf("%d",&x);
   for(i=0;i<=x;i++)
        sum1=sum1+i;
   return sum1;
}
