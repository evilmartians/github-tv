# Github-TV: Forks your colleagues' open-source repos to organization page

This is just a POC.

## Usage

```bash
gem install github-tv
github-tv *path/url for config*
```

Config should be in format of

```yaml
---
organization: where_to_sync_repos
repos:
  - user1/repo1
  - user2/repo2
```

Optionally, you can set default path/url to config file.

```bash
git config --global github.tv.config *path/url for config*
```

## Contributors

* @gazay, @brainopia, @igas, @aderyabin

## License

The MIT License
