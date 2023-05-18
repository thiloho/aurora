---
title: "Markdown style guide"
publicationDate: 2023-05-17
description: "Here is a sample of some basic Markdown syntax that can be used when writing Markdown content in Astro."
---

## Headings

### H3

#### H4

## Inline styles

hello **bold** the brown fox jumps _italicized text_ over the `code` high fence [link](https://example.com) and ~~the world is flat~~.

## Blockquote

> Be courteous to all, but intimate with few, and let those few be well tried before you give them your confidence. True friendship is a plant of slow growth, and must undergo and withstand the shocks of adversity before it is entitled to the appellation.<br>
> — <cite>George Washington</cite>

## Lists

### Ordered list

1. First item
2. Second item
3. Third item

### Unordered list

- First item
- Second item
- Third item

## Horizontal rule

---

## Image

![Minke Whale breaching in Antarctica](../../assets/blog/markdown-style-guide/example-image.jpg)

## Table

This is technically not a table anymore. To make it completely responsive, I applied `display: block` and `overflow-x: auto` on the `table` element.

| Syntax    | Description |
| --------- | ----------- |
| Header    | Title       |
| Paragraph | Text        |

## Fenced code block

```json
{
  "firstName": "John",
  "lastName": "Smith",
  "age": 25
}
```
