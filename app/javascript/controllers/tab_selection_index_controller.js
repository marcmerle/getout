import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["location", "genres", "tabLocation", "tabGenres" ];

  connect() {
    if (localStorage.locationTab) this.retrieveTab(localStorage.locationTab);
    const params = new URLSearchParams(window.location.search);
    if (params.get('query')) this.retrieveTab("location");
  }

  retrieveTab(tabName) {
    if (tabName === "location") {
      this.locationTarget.click();
      this.activateLocation();
    } else {
      this.genresTarget.click();
      this.activateGenres();
    }
  }

  changeTab(e) {
    if (e.target === this.locationTarget) {
      this.activateLocation();
    } else {
      this.activateGenres();
    }
  }

  activateLocation() {
    localStorage.locationTab = "location";
    this.tabGenresTarget.classList.remove("show", "active");
    this.tabLocationTarget.classList.add("show", "active");

    const event = new CustomEvent("genres_shown");
    window.dispatchEvent(event);
  }

  activateGenres() {
    localStorage.locationTab = "genres";
    this.tabLocationTarget.classList.remove("show", "active");
    this.tabGenresTarget.classList.add("show", "active");

    const event = new CustomEvent("genres_shown");
    window.dispatchEvent(event);
  }
}
