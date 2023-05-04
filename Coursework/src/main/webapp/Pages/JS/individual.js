document.querySelectorAll('.side-image').forEach((image) => {
    image.addEventListener('click', () => {
        document.getElementById('main-image').src = image.src;
    });
});
