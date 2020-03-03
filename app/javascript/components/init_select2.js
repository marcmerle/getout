import $ from 'jquery';
import 'select2';

const genresSearch = document.querySelector(".genres-search");
const genres = genresSearch.dataset.genres.split(",")

const initSelect2 = () => {
  $('#genres-search-bar-select').select2({ data: genres,
                                           placeholder: "Enter a genre",
                                           maximumSelectionLength: 60,
                                           action: "change->select2-genres#setColors",
                                           target: "select2-genres.searchSelect"
                                         });

};

$('#genres-search-bar-select').on('select2:select', function (e) {
    setColors();
  });

$('#genres-search-bar-select').on('select2:unselect', function (e) {
    setColors();
  });

const setColors = () => {
  const colors = genresSearch.dataset.colors.split(",")
  const genresForm = document.querySelector(".genres-search-form")
  const choices = document.querySelectorAll(".select2-selection__choice");
  const genresToForm = []
  choices.forEach((choice) => {
    const genreIndex = genres.indexOf(choice.getAttribute('title'));
    const color = colors[genreIndex];
    choice.setAttribute("style", `background-color: ${color}`)
    genresToForm.push(choice.getAttribute('title'))
  });
  genresForm.elements.genres.value = genresToForm.join('+')

}

export { initSelect2 };
