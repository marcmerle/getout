import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["tag", "addForm", "removeForm"];

  connect() {
    this.tagTargets.forEach(tag => {
      if (tag.dataset.chosen === "true") {
        this.setTagColor(tag, "#fffdf7", tag.dataset.color, tag.dataset.color);
      }
    });

    if (window.location.href.match("dashboard/likes")) {
      const savedFlash = document.querySelector('.saved-flash')
      $(savedFlash).hide(0)
    }
  }

  setTagColor(element, fontColor, borderColor, backgroundColor) {
    const style =
      `border: 1px solid ${borderColor}; ` +
      `color: ${fontColor}; ` +
      `box-shadow: 0 0px 4px 0px ${borderColor}; ` +
      `background: ${backgroundColor};`;

    element.setAttribute("style", style);
  }

  toggleSelection(event) {
    const tag = event.target;
    const genre_id = parseInt(tag.dataset.genre);

    if (tag.dataset.chosen === "true") {
      this.setTagColor(tag, "#ef798a", "#ef798a", "none");
      tag.dataset.chosen = "false";
      this.removeFormTarget.elements.genre_id.value = genre_id;
      Rails.fire(this.removeFormTarget, "submit");
    } else {
      this.setTagColor(tag, "#fffdf7", tag.dataset.color, tag.dataset.color);
      tag.dataset.chosen = "true";
      this.addFormTarget.elements.genre_id.value = genre_id;
      Rails.fire(this.addFormTarget, "submit");
    }
    if (window.location.href.match("dashboard/likes")) {
      const tastesDashboard = document.querySelector('.tastes-dashboard')

      const savedFlash = document.querySelector('.saved-flash')

      window.setTimeout(() => {
        $(savedFlash).fadeIn(300);
        window.setTimeout(() => {
          $(savedFlash).fadeOut(500);
        }, 1000);
      }, 100);
    }
  }
}
