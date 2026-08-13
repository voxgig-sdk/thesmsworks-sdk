# Thesmsworks SDK utility: make_context

from projectname_sdk.core.context import ThesmsworksContext


def make_context_util(ctxmap, basectx):
    return ThesmsworksContext(ctxmap, basectx)
