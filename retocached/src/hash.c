/* -*- Mode: C; tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*- */

#include "memcached.h"
#include "jenkins_hash.h"
#include "murmur3_hash.h"

int hash_init(enum hashfunc_type type) {
    hash = MurmurHash3_x86_64;
    settings.hash_algorithm = "murmur3";
    return 0;
}
