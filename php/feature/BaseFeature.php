<?php
declare(strict_types=1);

// Thesmsworks SDK base feature

class ThesmsworksBaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(ThesmsworksContext $ctx, array $options): void {}
    public function PostConstruct(ThesmsworksContext $ctx): void {}
    public function PostConstructEntity(ThesmsworksContext $ctx): void {}
    public function SetData(ThesmsworksContext $ctx): void {}
    public function GetData(ThesmsworksContext $ctx): void {}
    public function GetMatch(ThesmsworksContext $ctx): void {}
    public function SetMatch(ThesmsworksContext $ctx): void {}
    public function PrePoint(ThesmsworksContext $ctx): void {}
    public function PreSpec(ThesmsworksContext $ctx): void {}
    public function PreRequest(ThesmsworksContext $ctx): void {}
    public function PreResponse(ThesmsworksContext $ctx): void {}
    public function PreResult(ThesmsworksContext $ctx): void {}
    public function PreDone(ThesmsworksContext $ctx): void {}
    public function PreUnexpected(ThesmsworksContext $ctx): void {}
}
