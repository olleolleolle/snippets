/*
 * Copyright (c) 1998  Dustin Sallings
 *
 * $Id: splat.h,v 1.4 1999/02/24 07:17:38 dustin Exp $
 */

#ifndef SPLAT_H
#define SPLAT_H

/* Debug stuff */
#ifndef PDEBUG
#define PDEBUG 1
#endif

#if (PDEBUG>0)
#ifndef _ndebug
#define _ndebug(a, b) if(_debug > a ) printf b;
#endif
#endif

/* In case it didn't make it */
#ifndef _ndebug
#define _ndebug(a, b)
#endif

#define REQ_LEN 1024

/* Socket options */
#define DO_NAGLE 1

/*
 * URL request holder.
 */
struct url {
	char   *host;
	int     port;
	char   *req;
	char    httpreq[REQ_LEN];
	int     ssl;
};

/*
 * Status return.
 */
struct status {
	int     status;
	int     bytesread;
	char   *message;
};

struct growstring {
	size_t size;
	char *string;
};

struct http_status {
	int status;
	char *string;
};

int     getclientsocket(char *host, int port, int flags);

#endif
