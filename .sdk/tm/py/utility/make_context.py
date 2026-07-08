# Thesmsworks SDK utility: make_context

from core.context import ThesmsworksContext


def make_context_util(ctxmap, basectx):
    return ThesmsworksContext(ctxmap, basectx)
