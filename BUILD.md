# Build Instructions

## Upgrade Dependencies

1. Modify `Gemfile`

2. Run

    ```
    bundle update
    ```

## Rune Test Suite

```
bundle exec rake spec
```

## Deploy New Version

1. Change version in the following files

    1. `lib/active_service/version.rb`

    2. `VERSION`

2. Add entry to `CHANGELOG.md`

3. Run

    ```
    bundle exec rake gemspec
    ```

4. Commit, push, and create a _Release_ on GitHub
