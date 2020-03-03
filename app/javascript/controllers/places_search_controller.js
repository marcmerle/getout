import { Controller } from "stimulus";
import places from "places.js";

export default class extends Controller {
  static targets = ["input", "form"];

  connect() {
    places({ container: this.inputTarget });
  }

  onKeyEnter(event) {
    if (event.keyCode == 13) {
      this.formTarget.submit();
    }
  }

  highlight() {
    this.inputTarget.select();
  }
}
