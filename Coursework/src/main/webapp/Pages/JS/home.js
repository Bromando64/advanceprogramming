const slider = document.querySelector(".banner-slider");
const slides = document.querySelectorAll(".banner-slide");
const slideCount = slides.length;

let currentIndex = 0;
let interval = 3000; // Time interval in milliseconds

function slide() {
    slider.style.transform = `translateX(-${(currentIndex * 100) / slideCount}%)`;

    currentIndex += 1;

    if (currentIndex >= slideCount) {
        currentIndex = 0;
    }
}

slider.addEventListener("click", () => {
    clearInterval(autoSlide);
    slide();
    autoSlide = setInterval(slide, interval);
});

let autoSlide = setInterval(slide, interval);
