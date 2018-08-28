dnl $Id$
dnl config.m4 for extension dreamphp

dnl Comments in this file start with the string 'dnl'.
dnl Remove where necessary. This file will not work
dnl without editing.

dnl If your extension references something external, use with:

dnl PHP_ARG_WITH(dreamphp, for dreamphp support,
dnl Make sure that the comment is aligned:
dnl [  --with-dreamphp             Include dreamphp support])

dnl Otherwise use enable:

PHP_ARG_ENABLE(dreamphp, whether to enable dreamphp support,
Make sure that the comment is aligned:
[  --enable-dreamphp           Enable dreamphp support])

if test "$PHP_DREAMPHP" != "no"; then
  dnl Write more examples of tests here...

  dnl # --with-dreamphp -> check with-path
  dnl SEARCH_PATH="/usr/local /usr"     # you might want to change this
  dnl SEARCH_FOR="/www/server/php/70/src/ext/php_dreamphp/php_dreamphp.h"  # you most likely want to change this
  dnl if test -r $PHP_DREAMPHP/$SEARCH_FOR; then # path given as parameter
  dnl   DREAMPHP_DIR=$PHP_DREAMPHP
  dnl else # search default path list
  dnl   AC_MSG_CHECKING([for dreamphp files in default path])
  dnl   for i in $SEARCH_PATH ; do
  dnl     if test -r $i/$SEARCH_FOR; then
  dnl       DREAMPHP_DIR=$i
  dnl       AC_MSG_RESULT(found in $i)
  dnl     fi
  dnl   done
  dnl fi
  dnl
  dnl if test -z "$DREAMPHP_DIR"; then
  dnl   AC_MSG_RESULT([not found])
  dnl   AC_MSG_ERROR([Please reinstall the dreamphp distribution])
  dnl fi

  dnl # --with-dreamphp -> add include path
  dnl PHP_ADD_INCLUDE($DREAMPHP_DIR/include)

  dnl # --with-dreamphp -> check for lib and symbol presence
  dnl LIBNAME=dreamphp # you may want to change this
  dnl LIBSYMBOL=dreamphp # you most likely want to change this 

  dnl PHP_CHECK_LIBRARY($LIBNAME,$LIBSYMBOL,
  dnl [
  dnl   PHP_ADD_LIBRARY_WITH_PATH($LIBNAME, $DREAMPHP_DIR/$PHP_LIBDIR, DREAMPHP_SHARED_LIBADD)
  dnl   AC_DEFINE(HAVE_DREAMPHPLIB,1,[ ])
  dnl ],[
  dnl   AC_MSG_ERROR([wrong dreamphp lib version or lib not found])
  dnl ],[
  dnl   -L$DREAMPHP_DIR/$PHP_LIBDIR -lm
  dnl ])
  dnl
  dnl PHP_SUBST(DREAMPHP_SHARED_LIBADD)

  PHP_NEW_EXTENSION(dreamphp, dreamphp.c, $ext_shared,, -DZEND_ENABLE_STATIC_TSRMLS_CACHE=1)
fi
