# Metamatter

Minimal metadata extractor for the GitHub API. Ultimately the goal is to get this to produce output similar to that described in [this blog post](http://www.arfon.org/json-ld-for-software-discovery-reuse-and-credit).

[![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.18873.svg)](http://dx.doi.org/10.5281/zenodo.19630)

```javascript
{
  "@context": "http://schema.org",
  "@type": "Code",
  "name": "Fidgit",
  "codeRepository": "https://github.com/arfon/fidgit",
  "citation": "http://dx.doi.org/10.6084/m9.figshare.828487",
  "description": "An ungodly union of GitHub and Figshare http://fidgit.arfon.org",
  "dateCreated": "2013-10-19",
  "license": "http://opensource.org/licenses/MIT",
  "author": {
    "@type": "Person",
    "name": "Arfon Smith",
    "@id": "http://orcid.org/0000-0002-3957-2474",
    "email": "arfon@github.com"
  }
}
```

## Usage

```ruby
ALGORITHMIA_TOKEN = your_algorithmia_token
GITHUB_TOKEN = your_github_token

repository = Metamatter::Repository.new('arfon/metamatter')
repository.extract    #=> '{"authors": [{"name": "Arfon Smith", "email":"arfon.smith@gmail.com" ...

```

```bash
GITHUB_TOKEN=your_github_token ALGORITHMIA_TOKEN=your_algorithmia_token\
metamatter extract arfon/metamatter

{
  "authors": [
    {
      "name": "Arfon Smith",
      "email": "arfon.smith@gmail.com",
      "login": "arfon",
      "contributions": 7
    }
  ],
  "tags": [
    "api",
    "extractor",
    "minimal",
    "metadata",
    "github",
    "metamatter"
  ]
}

```
