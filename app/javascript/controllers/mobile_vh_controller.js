import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    this.updateHeight();
  }

  updateHeight() {
    let vh = window.innerHeight * 0.01;
    document.documentElement.style.setProperty("--vh", `${vh}px`);
  }
}
