# dcape Makefile
SHELL            ?= /bin/bash
CFG              ?= .env

#- ******************************************************************************
#- Postgresql: general config

#- Postgresql docker image
DB_IMAGE         ?= postgres
#- Postgresql docker image version
DB_VER           ?= 15.2

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

DCAPE_ROOT ?= ../../
# ------------------------------------------------------------------------------

-include $(CFG)
export

ifdef DCAPE_STACK
-include $(DCAPE_ROOT)/.env
export
include $(DCAPE_ROOT)/Makefile.dcape
else
include $(DCAPE_ROOT)/Makefile.app
endif

init:

setup:
	@echo "Setup..."
	$(MAKE) -s up-db
	$(MAKE) -s docker-wait

