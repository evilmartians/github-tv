# Github-TV: Forks your colleagues' open-source repos to organization page

This is just a POC.

## Usage

```bash
bundle install
bundle exec ruby script.rb
Enter your github login:
Enter your github password:
Name of organization:
what to do? (0 - fork, 1 - renew):
```

Just install gems with bundle, then run `script.rb` with bundle and answer for some questions.

Right now list of projects right in this projects tree in `projects.yml` file.
Add new items to it in 'short github' format `author/project_name`.

If you choose `0` - projects from list will be forked to chosen organization.
They will not re-forked if they already there and they will not Fast-Forwarded if your forks outdated.

If you choose `1` – now programm suppose that you already have forks in your organization.
It will clone forks locally, add original repos as `original` remote branches and pull from `original master` to fork's `master`. Then it will push (without force) to fork repo back. And then delete temp directory with cloned repos.

## Contributors

* @gazay

## License

The MIT License
