import { Controller } from "stimulus";

export default class extends Controller {
  displayMessage() {
    const fetchMessage = document.querySelector(".fetching-message")
    fetchMessage.setAttribute("style", "display: inline")
  }
}
