import Rails from '@rails/ujs';

const initFillTag = () => {
  if (document.querySelector(".tastes")) {

    const tags = document.querySelectorAll(".tag");
    const add_form = document.getElementById("add_user_genre");
    const remove_form = document.getElementById("remove_user_genre");

    const setTagColor = (object, fontColor, borderColor, backgroundColor) => {
      object.setAttribute("style", `border: 1px solid ${borderColor}; color: ${fontColor}; box-shadow: 0 0px 4px 0px ${borderColor}; background: ${backgroundColor}`);
    }

    tags.forEach((tag) => {

      if (tag.dataset.chosen === "true") {
        setTagColor(tag, "#fffdf7", tag.dataset.color, tag.dataset.color)
      }

      const genre_id = parseInt(tag.dataset.genre);

      tag.addEventListener('click', (event) => {

        if (tag.dataset.chosen === "true") {

          setTagColor(tag, "#ef798a", "#ef798a", "none")
          tag.dataset.chosen = "false";
          remove_form.elements.genre_id.value = genre_id;
          Rails.fire(remove_form, 'submit');

        } else {

          setTagColor(tag, "#fffdf7", tag.dataset.color, tag.dataset.color)
          tag.dataset.chosen = "true";
          add_form.elements.genre_id.value = genre_id;
          // add_form.submit();
          Rails.fire(add_form, 'submit')
        }

      });
    });
  };
};

export {initFillTag};
