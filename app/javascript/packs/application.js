// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import "bootstrap"
import 'popper.js'
import Sortable from "sortablejs"


document.addEventListener('turbolinks:load', (event) => {
  console.log('DOM fully loaded and parsed');
  let bagList = document.getElementById("bag-list")
  if (bagList) {
    console.log("found bag list")
    Sortable.create(bagList, {
      onSort: (e) => {
        let positionFields = bagList.querySelectorAll(".position-field")
        console.log(positionFields)
        Array.from(positionFields).forEach((field, index) => {
          field.value = index
        })
      }
    })
  }
});