import { Controller } from "stimulus";
import $ from "jquery";
import "select2";
import "select2/dist/css/select2.css";

export default class extends Controller {
  static targets = ["input", "form", "genres", "results", "searchSelect"];

  connect() {
    this.genres = this.genresTarget.dataset.genres.split(",");
    this.colors = this.genresTarget.dataset.colors.split(",");

    $(this.inputTarget).select2({
      width: "100%",
      data: this.genres,
      placeholder: "Enter a genre",
      maximumSelectionLength: 60
    });

    $(this.inputTarget).on("select2:select", () => {
      const event = new CustomEvent("select_change");
      window.dispatchEvent(event);
    });

    $(this.inputTarget).on("select2:unselect", () => {
      const event = new CustomEvent("select_change");
      window.dispatchEvent(event);
    });
  }

  tagChange() {
    this.setColors();
    this.triggerSearch();
  }

  triggerSearch() {
    if (this.searchSelectTarget.value === "")
      return this.resultsTarget.classList.remove("showing");

    this.resultsTarget.classList.add("showing");

    fetch("/places/genres.html?query_genres=" + this.searchSelectTarget.value)
      .then(response => {
        return response.text();
      })
      .then(html => {
        this.resultsTarget.innerHTML = html;
      });
  }

  setColors() {
    const choices = document.querySelectorAll(".select2-selection__choice");
    const genresToForm = [];

    choices.forEach(choice => {
      const genreIndex = this.genres.indexOf(choice.getAttribute("title"));
      const color = this.colors[genreIndex];

      choice.setAttribute("style", `background-color: ${color}`);
      genresToForm.push(choice.getAttribute("title"));
    });

    this.formTarget.elements.genres.value = genresToForm.join("+");
  }
}
