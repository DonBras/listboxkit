# @donbras/listboxkit

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/DonBras/listboxkit/release.yml?branch=master&style=flat-square)
[![npm](https://img.shields.io/npm/v/@donbras/listboxkit?style=flat-square)](https://www.npmjs.com/package/@donbras/listboxkit)
[![npm bundle size](https://img.shields.io/bundlephobia/min/@donbras/listboxkit?style=flat-square)](https://bundlephobia.com/result?p=@donbras/listboxkit)
![Codecov](https://img.shields.io/codecov/c/github/DonBras/listboxkit?style=flat-square)

Light and flexible React hooks written in ReScript for building accessible listbox composed components, like menus, dropdown select and others.

> This package is a fork of [`listboxkit`](https://github.com/brnrdog/listbox) by Bernardo Gurgel. The functionality is identical; only the dependency toolchain has been modernized (Node 20+, jest 30, rollup 4, semantic-release 24, dropped BuckleScript-era packages, current `@rescript/react`). The public API of the hooks is unchanged.

## Installation

Install it using the package manager of your preference:

```bash
npm install --save @donbras/listboxkit
```

Or if your project uses yarn:

```bash
yarn add @donbras/listboxkit
```

For **ReScript** projects, add `@donbras/listboxkit` as a dependency in your `bsconfig.json` file:

```json
{
  "bs-dependencies": ["@donbras/listboxkit"]
}
```

## Usage

The main React hook for building listbox components is the `useListbox`. Given a list of options, this hook will provide the state and the necessary event handlers for building your listbox.

### Using in JavaScript/TypeScript projects:

```js
const options = ["Red", "Green", "Blue"];

function ColorSelect() {
  const {
    highlightedIndex,
    getOptionProps,
    getContainerProps,
    selectedIndexes
  } = useListbox(options);

  const selectedColors = selectedIndexes.map(i => options[i]).join(",")

  return (
    <div>
      Selected color:{" "}
      {selectedColors.length === 0 ? "no selected color" : selectedColors}.
      <ul {...getContainerProps()}>
        {options.map((option, index) => {
          const highlighted = highlightedIndex === index;

          return (
            <li {...getOptionProps(index)}>
              {highlighted ? `> ${option}` : option}
            </li>
          );
        })}
      </ul>
    </div>
  );
```

### Using in ReScript projects:

```rescript
module ColorSelect {
  let options = ["Red", "Green", "Blue"]

  @react.component
  let make = () => {
    let {
      highlightedIndex,
      getOptionProps,
      getContainerProps,
      selectedIndexes
    }: Listbox.listbox = Listbox.useListbox(options)

    let { role, tabIndex, onKeyDown, onFocus, onBlur } = getContainerProps()

    let selectedOption = selectedIndexes
    -> Belt.Array.map(i => options -> Belt.Array.get(i))
    -> Belt.Array.get(0)
    -> Belt.getWithDefault("no selected color.")

    let renderColorOption = (index, option) => {
      let {
        ariaSelected,
        onClick,
        role,
      }: Listbox.optionProps = getOptionProps(index)
      let highlighted =  highlightedIndex == index

      <li key=option onClick onKeyDown role ariaSelected>
        {(highlighted ? `> ${option}` : option) |> React.string}
      </li>
    }

    <div>
      {React.string("Selected color :" ++ selectedOption)}
      <ul role tabIndex onKeyDown onFocus onBlur>
        {options
          -> Belt.Array.mapWithIndex(renderOption)
          -> React.array}
      </ul>
    </div>
  }
}
```
