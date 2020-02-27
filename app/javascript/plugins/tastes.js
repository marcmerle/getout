const initFillTag = () => {
  if (document.querySelector(".tastes")) {

    const tags = document.querySelectorAll(".tag");

    tags.forEach((tag) => {
      tag.addEventListener('click', (event) => {
        if (tag.dataset.chosen === "true") {
          event.currentTarget.setAttribute("style", "border: 1px solid #ef798a; color: #ef798a; box-shadow: 0 0px 4px 0px #ef798a;");
          tag.dataset.chosen = false
        } else {
          event.currentTarget.setAttribute("style", "border: 1px solid #251351; color: #fffdf7; box-shadow: 0 0px 4px 0px #251351; background: #251351");
          tag.dataset.chosen = true
        }
      });
    });
  };
};

export {initFillTag};
