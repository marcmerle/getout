import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["menu"];

  toggleDropdown(e) {
    if (this.menuTarget.style.display == 'block') {
      this.menuTarget.style.display = 'none'
    } else {
      this.menuTarget.style.display = 'block'
    }
  }
}
