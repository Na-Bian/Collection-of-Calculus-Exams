#!/bin/sh
export PERL5LIB="$HOME/perl5/lib/perl5:$HOME/perl5/lib/perl5/darwin-thread-multi-2level${PERL5LIB:+:$PERL5LIB}"
LATEXINDENT_BIN="$(command -v latexindent 2>/dev/null || true)"
if [ -z "$LATEXINDENT_BIN" ]; then
  LATEXINDENT_BIN="$HOME/bin/latexindent"
fi
exec "$LATEXINDENT_BIN" "$@"
