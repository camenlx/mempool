#!/bin/bash

DESTDIR=/dev/shm/mempool-zoc
ZOCCLI=$HOME/zeroone/zeroone-cli
DATADIR=$HOME/.zeroonetest
MEMPOOLHOME=$HOME/mempool
TMPFILE=$DESTDIR/rawdump.txt

export DESTDIR MEMPOOLHOME
mkdir -p $DESTDIR
cd $MEMPOOLHOME

if ! mkdir $DESTDIR/LOCK 2>/dev/null; then
  exit
fi
$ZOCCLI -datadir=$DATADIR getrawmempool true > $TMPFILE
python3 mempool_sql.py < $TMPFILE
rmdir $DESTDIR/LOCK

if ! mkdir $DESTDIR/DATALOCK 2>/dev/null; then
  exit
fi
./mkdata.sh
rmdir $DESTDIR/DATALOCK
