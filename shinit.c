#include <stdio.h>
main()
{
  char *s[2] = {"/bin/sh",NULL };
  execve( s[0], s, NULL );
  exit(0);
}
