import Testing

extension Tag {
    /// Live-server PTZ tests. Skipped unless `ONEPTZ_TEST_INTEGRATION=1` and credentials are set.
    ///
    /// Run: `ONEPTZ_TEST_INTEGRATION=1 ONEPTZ_TEST_PASSWORD=… swift test --filter PtzSessionIntegrationTests`
    @Tag static var integration: Tag
}
