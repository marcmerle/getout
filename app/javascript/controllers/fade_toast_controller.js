import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["toast"];

  connect() {
    window.setTimeout(this.fade.bind(this), 3000);
  }

  fade() {
    const element = this.toastTarget;
    element.style.opacity = 1;

    const reduceOpacity = () => {
      if ((element.style.opacity -= 0.1) < 0) {
        element.style.display = "none";
      } else {
        window.requestAnimationFrame(reduceOpacity);
      }
    };

    reduceOpacity();
  }
}
