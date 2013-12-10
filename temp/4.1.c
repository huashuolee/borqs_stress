#include<stdio.h>
#include<math.h>

int main()
{
   double a,b,c,d,e,x1,x2;
   printf("input 3 number\n");
   scanf("%lf%lf%lf",&a,&b,&c);
   d=b*b-4*a*c;
   if(d<0)
     printf("these is no real roots\n");
   else
   {
   e=sqrt(d);
   x1=-b/(2.0*a)+e/(2.0*a);
   x2=-b/(2.0*a)-e/(2.0*a);
   printf("the roots are\n%7.2f\n%f\n",x1,x2);   
   }
   return 0;
  
}
// a=2 b=-4 c=2
