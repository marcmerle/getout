// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
//= require select2

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------
import "controllers";
import "bootstrap";
import { labelToggle } from '../controllers/tab_filters';

document.addEventListener('turbolinks:load', () => {
  labelToggle();
});

const allLabels = document.querySelectorAll(".tags-filter li")

const toggleTag = (event) => {
  allLabels.forEach((label) => {
    label.classList.add("grey-tag");
  })
  event.currentTarget.classList.remove("grey-tag")
}


allLabels.forEach((label) => {
  label.addEventListener("click", toggleTag);
})
