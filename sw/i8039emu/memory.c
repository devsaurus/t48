/*
 * $Id: memory.c,v 1.1.1.1 2004-04-09 19:20:54 arniml Exp $
 *
 * Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
 *
 * All rights reserved
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version. See also the file COPYING which
 *  came with this application.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */

#include <stdio.h>
#include <string.h>

#include "memory.h"


static UINT8 code_mem[4096];



UINT8 program_read_byte_8(UINT16 address)
{
  return(0);
}

UINT8 cpu_readop(UINT16 address)
{
  return(code_mem[address]);
}

UINT8 cpu_readop_arg(UINT16 address)
{
  return(code_mem[address]);
}

UINT8 io_read_byte_8(UINT8 address)
{
  return(0);
}

void io_write_byte_8(UINT8 address, UINT8 data)
{
}


int read_hex_file(char *filename)
{
  FILE *hex_file;
  UINT16 record_len, offset, record_type;
  UINT16 byte;
  char line[540];
  char *payload, *idx;
  int result = 0;

  record_len = offset = record_type = 0;
  hex_file = fopen(filename, "r");
  if (hex_file != NULL) {

    while (fgets(line, 539, hex_file)) {
      if (sscanf(line, ":%2hx%4hx%2hx", &record_len, &offset, &record_type) == 3) {
        /* strip off newline */
        idx = (char *)strchr(line, '\n');
        if (idx != NULL)
          *idx = '\0';
        /* extract payload */
        payload = &(line[9]);
        /* strip of checksum */
        if (strlen(payload) > 2)
          payload[strlen(payload) - 2] = '\0';

        /* read payload to array */
        if (record_type == 0) {
          while (strlen(payload) >= 2) {
            if (sscanf(payload, "%2hx", &byte) == 1)
              code_mem[offset++] = byte;

            payload++;
            payload++;
          }
        }

      }
    }

    result = 1;

    fclose(hex_file);
  }

  return(result);
}
