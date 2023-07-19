## postgres Makefile.
## Used with dcape at ../../
#:

SHELL            ?= /bin/bash
CFG              ?= .env

# Docker image version tested for actual dcape release
DB_VER0          ?= 15.2

#- ******************************************************************************
#- Postgresql: general config

#- Postgresql docker image
DB_IMAGE         ?= postgres
#- Postgresql docker image version
DB_VER           ?= $(DB_VER0)

#- ------------------------------------------------------------------------------
#- Postgresql: internal config

#- Postgresql container hostname
DB_HOSTNAME      ?= db

#- Postgresql Database superuser password
DB_ADMIN_PASS    ?= $(shell openssl rand -hex 16; echo)
#- Postgresql Database encoding
DB_ENCODING      ?= en_US.UTF-8
#- port on localhost postgresql listen on
DB_PORT_LOCAL    ?= 5433
#- shared memory
DB_SHM_SIZE      ?= 64mb
#- initdbargs for customise create postgres cluster
DB_INITDB_ARGS   ?= --lc-message=C --auth-host=md5

#- dcape root directory
DCAPE_ROOT       ?= $(DCAPE_ROOT)

# ------------------------------------------------------------------------------

-include $(CFG)
export

ifdef DCAPE_STACK
include $(DCAPE_ROOT)/Makefile.dcape
else
include $(DCAPE_ROOT)/Makefile.app
endif

# ------------------------------------------------------------------------------

# check app version
init:
	@if [[ "$$DB_VER0" != "$$DB_VER" ]] ; then \
	  echo "Warning: DB_VER in dcape ($$DB_VER0) differs from yours ($$DB_VER)" ; \
	fi
