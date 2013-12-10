#include<stdio.h>

int main()
{
    int x,y,z;
    printf("input 2 int:\n");
    z=max(x,y);
        printf("the max is %d\n",z);
    return 0;

}

int max(int x,int y)
{
    scanf("%d%d",&x,&y);
    if(x>y) return x;
    else return y;
    
}


