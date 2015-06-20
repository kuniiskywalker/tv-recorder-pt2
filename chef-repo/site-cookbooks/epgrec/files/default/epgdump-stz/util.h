#ifndef UTIL_H
#define UTILH 1

#include <time.h>

#define MAXSECLEN 4096

#ifdef __cplusplus
extern "C"{
#endif /* __cplusplus */

	int   strrep(char *, char *, char *);
	int   getBit(unsigned char *byte, int *pbit, int gbit);
	void  getStr(char *tostr, unsigned char *byte, int *pbit, int len);
	int   parseOTHERdesc(unsigned char *data);

	time_t getStartTime(unsigned char *starttime);
	int getDurationSec(unsigned char *duration);
	char *strTime(time_t tx,char *format);

#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif
