#ifndef __STRING_H__
#define __STRING_H__
#include <systypes.h>
extern __ksize strlen(const __ks8* str);
__ksize strlen(const __ks8* str)
{
__ksize i = 0;
while (str[i++] != '\0')
;
return --i;
}
#endif//__STRING_H__ 
