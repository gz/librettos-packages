#ifndef HASH_H
#define    HASH_H

typedef uint64_t (*hash_func)(const void *key, size_t length);
hash_func hash;

enum hashfunc_type {
    MURMUR3_HASH=0, JENKINS_HASH=1
};

int hash_init(enum hashfunc_type type);

#endif    /* HASH_H */
