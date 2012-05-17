###
jquery-currency-input
Copyright (c) 2012 Greg Leaver

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
###


$ = jQuery


# From _.isFinite
isNumber = (obj) ->
  toString.call(obj) == '[object Number]' and isFinite(obj)

toNumber = (str) -> 
  str = str.toString().replace /[$,\s]/g, ''
  parseFloat(str)

left = (num) ->
  str = Math.floor(num).toFixed().toString()
  digits = str.split('').reverse()
  grouped = []
  while digits.length > 3
    grouped.push digits.shift() for i in [1..3]
    grouped.push ','
  grouped.push i for i in digits
  grouped.reverse().join ''

right = (num) ->
  (num - Math.floor(num)).toFixed(2).replace /\d*\./, ''

format = (num) -> 
  unless isNumber num
    format(toNumber(num))
  else
    "$ #{left num}.#{right num}"

$ ->
  $('input[type="currency"]').each ->
    $(this).closest('form').submit () =>
      this.value = toNumber this.value
      return true
    $(this).blur () => 
      this.value = format this.value
