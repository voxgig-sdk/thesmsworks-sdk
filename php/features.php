<?php
declare(strict_types=1);

// Thesmsworks SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';


class ThesmsworksFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new ThesmsworksBaseFeature();
            case "test":
                return new ThesmsworksTestFeature();
            default:
                return new ThesmsworksBaseFeature();
        }
    }
}
