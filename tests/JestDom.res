%%raw(`require("@testing-library/jest-dom")`)

type expect
type t = Dom.element

@val external expect: t => expect = "expect"

@send external _toBeInTheDocument: expect => unit = "toBeInTheDocument"
let toBeInTheDocument = (e: expect): Jest.assertion => {
  e->_toBeInTheDocument
  Jest.pass
}

@send external _toBeVisible: expect => unit = "toBeVisible"
let toBeVisible = (e: expect): Jest.assertion => {
  e->_toBeVisible
  Jest.pass
}

@send external _toHaveAttribute: (expect, string) => unit = "toHaveAttribute"
@send external _toHaveAttributeWithValue: (expect, string, string) => unit = "toHaveAttribute"
let toHaveAttribute = (name, ~value=?, e: expect): Jest.assertion => {
  switch value {
  | None => e->_toHaveAttribute(name)
  | Some(v) => e->_toHaveAttributeWithValue(name, v)
  }
  Jest.pass
}

@send external _toHaveTextContentStr: (expect, string) => unit = "toHaveTextContent"
@send external _toHaveTextContentRe: (expect, Js.Re.t) => unit = "toHaveTextContent"
@send external _toHaveTextContentArr: (expect, array<string>) => unit = "toHaveTextContent"
let toHaveTextContent = (
  text: [#Str(string) | #RegExp(Js.Re.t) | #Arr(array<string>)],
  e: expect,
): Jest.assertion => {
  switch text {
  | #Str(s) => e->_toHaveTextContentStr(s)
  | #RegExp(r) => e->_toHaveTextContentRe(r)
  | #Arr(a) => e->_toHaveTextContentArr(a)
  }
  Jest.pass
}
