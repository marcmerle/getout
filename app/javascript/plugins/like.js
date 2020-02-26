
const initLike = () => {
  const like = document.querySelector(".far.fa-heart");
  like.addEventListener('click', (event) => {
    event.currentTarget.classList.toggle("far")
    event.currentTarget.classList.toggle("fas")
  });
}

export default initLike

