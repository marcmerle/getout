import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["shareButton"];

  triggerShare() {
    const shareButton = document.querySelector(".fas.fa-share-alt")

    shareButton.addEventListener('click', (event) => {
      if (navigator.share) {
        const title = document.title;
        const url = document.querySelector('link[rel=canonical]') ? document.querySelector('link[rel=canonical]').href : document.location.href;
        navigator.share({
          title: title,
          url: url
        })
        .catch(console.error);
      }
    });
  }
}
