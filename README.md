# Codecov Check Docker Action

This actions checks if the total code coverage of project is below a threshold. The code coverage must have been previously uploaded to codecov.io.

## Inputs

## token

**Required** The token used to authenticate against the codecov.io API.

## threshold

**Required** The minimum total code coverage that is required to pass.

## Outputs

## Example usage
```yaml
uses: Berling/codecov-check@v2
```
