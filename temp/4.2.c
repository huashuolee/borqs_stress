#include<stdio.h>
int main()
{
   float a,b,c,d;
   scanf("%f%f",&a,&b);
   if(a>b)
      printf("%1.1f %1.1f\n",a,b);
   else
      printf("%1.1f %1.1f\n",b,a);
   return 0;

}
