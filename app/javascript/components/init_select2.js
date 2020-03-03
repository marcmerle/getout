import $ from 'jquery';
import 'select2';

const genresSearch = document.querySelector(".genres-search")

const genres = genresSearch.dataset.genres.split(",")
const colors = genresSearch.dataset.colors.split(",")

const initSelect2 = () => {
  $('#genres-search-bar-select').select2({ data: genres,
                                           placeholder: "Enter a genre",
                                           maximumSelectionLength: 60,
                                           height: '56px'});
};

const genresForm = document.querySelector(".genres-search-form")

const setColors = () => {
  const choices = document.querySelectorAll(".select2-selection__choice");
  const genresToForm = []
  choices.forEach((choice) => {
    const genreIndex = genres.indexOf(choice.getAttribute('title'));
    const color = colors[genreIndex];
    choice.setAttribute("style", `background-color: ${color}`)
    genresToForm.push(choice.getAttribute('title'))
  });
  genresForm.elements.genres.value = genresToForm.join('+')
  Rails.fire(genresForm, 'submit');

}

genresForm.addEventListener("click", (event) => {
  const genresSelect = document.querySelector(".select2-results__options")

  genresSelect.addEventListener('click', (event) => {
    setColors();
  });
  document.addEventListener('keyup', (event) => {
    setColors();
  });
setColors();
});

export { initSelect2 };
