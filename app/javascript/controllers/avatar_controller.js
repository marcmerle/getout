import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["button", "menu"];

  toggleDropdown() {
    if (this.menuTarget.style.display == "block") {
      this.menuTarget.style.display = "none";
    } else {
      this.menuTarget.style.display = "block";
    }
  }

  hide(event) {
    if (
      this.menuTarget.contains(event.target) ||
      this.buttonTarget.contains(event.target)
    ) {
      return;
    }

    this.menuTarget.style.display = "none";
  }
}
