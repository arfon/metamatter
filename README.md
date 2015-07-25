# Metamatter

[![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.18873.svg)](http://dx.doi.org/10.5281/zenodo.19630)
[![Build Status](https://travis-ci.org/arfon/metamatter.svg?branch=master)](https://travis-ci.org/arfon/metamatter)

Minimal metadata extractor for the GitHub API. Ultimately the goal is to get this to produce output similar to that described in [this blog post](http://www.arfon.org/json-ld-for-software-discovery-reuse-and-credit). Currently none of the entities in the output have any semantic context.

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
  "repository": {
    "name": "metamatter",
    "location": "https://github.com/arfon/metamatter",
    "description": "Minimal metadata extractor for the GitHub API",
    "created_at": "2015-07-06 10:42:12 UTC"
  },
  "authors": [
    {
      "name": "Arfon Smith",
      "email": "arfon.smith@gmail.com",
      "login": "arfon",
      "contributions": 10
    }
  ],
  "tags": [
    "api",
    "extractor",
    "minimal",
    "metadata",
    "github",
    "metamatter"
  ],
  "license": {
    "name": "MIT License",
    "url": "https://api.github.com/licenses/mit"
  },
  "doi": "http://dx.doi.org/10.5281/zenodo.19630"
}

```
