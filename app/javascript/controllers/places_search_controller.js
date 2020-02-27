import { Controller } from "stimulus";
import places from "places.js";

export default class extends Controller {
  static targets = ["input"];

  connect() {
    console.log(this.inputTarget);
    places({ container: this.inputTarget });
  }
}
