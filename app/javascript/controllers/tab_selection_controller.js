import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["list", "map", "tabList", "tabMap"];

  connect() {
    if (localStorage.mapTab) this.retrieveTab(localStorage.mapTab);
  }

  retrieveTab(tabName) {
    if (tabName === "list") {
      this.listTarget.click();
      this.activateList();
    } else {
      this.mapTarget.click();
      this.activateMap();
    }
  }

  changeTab(e) {
    if (e.target === this.listTarget) {
      this.activateList();
    } else {
      this.activateMap();
    }
  }

  activateList() {
    localStorage.mapTab = "list";
    this.tabMapTarget.classList.remove("show", "active");
    this.tabListTarget.classList.add("show", "active");
  }

  activateMap() {
    localStorage.mapTab = "map";
    this.tabListTarget.classList.remove("show", "active");
    this.tabMapTarget.classList.add("show", "active");

    const event = new CustomEvent("map_shown");
    window.dispatchEvent(event);
  }
}
