import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["icon", "iconContainer", "addForm", "removeForm"];

  connect() {
    if (this.iconTarget.dataset.liked === "true") {
      this.iconContainerTarget.innerHTML = "<i class='fas fa-heart' data-target='likes.icon', data-action='click->likes#toggleSelection', data-liked='true'></i>"
    }
  }

  toggleSelection() {
    if (this.iconTarget.dataset.liked === "false") {
      this.iconContainerTarget.innerHTML = "<i class='fas fa-heart' data-target='likes.icon', data-action='click->likes#toggleSelection', data-liked='true'></i>"
      Rails.fire(this.addFormTarget, "submit");
    } else {
      this.iconContainerTarget.innerHTML = "<i class='far fa-heart' data-target='likes.icon', data-action='click->likes#toggleSelection', data-liked='false'></i>"
      Rails.fire(this.removeFormTarget, "submit");
    }

  }
}
