import { Controller } from "stimulus"

export default class extends Controller {

  static targets = [ "searchButton", "searchSelect" ]

  connect() {

    $('#genres-search-bar-select').on('select2:select', function (e) {
      triggerSearch();
    });

    $('#genres-search-bar-select').on('select2:unselect', function (e) {
      triggerSearch();
    });

    const triggerSearch = () => {
      const resultsArea = document.querySelector('.genres-search-results');
      const hiddenSelectField = document.querySelector('#hidden-select-2');

      if (hiddenSelectField.value != "") {
        resultsArea.classList.add("showing")
        fetch('/places/genres.html?query_genres='+ hiddenSelectField.value)
            .then(response => {
              return response.text();
            })
            .then(html => {
              resultsArea.innerHTML=html;
            });
      } else {
          resultsArea.classList.remove("showing")
      }
    }
  }
}

