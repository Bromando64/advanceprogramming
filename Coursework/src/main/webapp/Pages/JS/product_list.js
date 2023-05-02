const checkboxes = document.querySelectorAll('.filter-options input[type="checkbox"]');

checkboxes.forEach(checkbox => {
    checkbox.addEventListener('change', (event) => {
        if (event.target.checked) {
            checkboxes.forEach(otherCheckbox => {
                if (otherCheckbox !== event.target) {
                    otherCheckbox.checked = false;
                }
            });
        }
    });
});