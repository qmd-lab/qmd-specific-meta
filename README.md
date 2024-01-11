# Reference document-specific meta data stored in _quarto.yml

This extension allows document-specific meta data to be stored in a single file instead of spread across the separate qmds. Note: many meta data fields do not behave as you might expect because this filter runs after Quarto filters that process meta data. For example, when `author` appears in document meta-data, it appears in the AST as `authors`, which is the field name that is drawn from when writing the author name into the title block.

## Installing

```bash
quarto add qmd-lab/qmd-specific-meta
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

Creating the glossary consists of three steps:

1. Add document meta data under the `qmd-specific-meta` key in your `_quarto.yml` file. See the `_quarto.yml` in this repo for an example.
2. Activate the filter on a given document. See `example1.qmd` for an example.

## Example

See [example1.qmd](example1.qmd) and <more-examples/example2.qmd>.
