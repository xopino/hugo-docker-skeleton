# Hugo setup with Docker

## Usage:

First of all, be sure the docker image is built:

```bash
make build
```
For creating a new project from scratch:

```bash
make init
```
If the project already exist, then just run the docker:
```bash
make run
```

## Configuration

### Theme:

Themes are stored under themes/ directory, and are configured through the config.yaml:

```bash
git submodule add "theme_git_url"
```
And on config.yaml, set the installed theme:
```yaml
theme: theme_name
```

