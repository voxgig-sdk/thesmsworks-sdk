<?php
declare(strict_types=1);

// Thesmsworks SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class ThesmsworksMakeContext
{
    public static function call(array $ctxmap, ?ThesmsworksContext $basectx): ThesmsworksContext
    {
        return new ThesmsworksContext($ctxmap, $basectx);
    }
}
