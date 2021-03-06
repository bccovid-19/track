---
---

const REGIONS_API_ENDPOINT = "{{ site.endpoints.regions }}";

window.onload = () => {
    fetch(REGIONS_API_ENDPOINT)
        .then(response => response.json())
        .then(data => renderFacilityRegions(data.regions));
    initAutocomplete();
};

const initAutocomplete = () => {
    // Create autocomplete object
    const autocomplete = new google.maps.places.Autocomplete(
        document.getElementById("facilityAddress"), {types: ['geocode']}
    );

    // restrict dataset to only address fields
    // WARNING: removing this restriction may cause additional charges on the GPC account
    autocomplete.setFields(['address_component']);
}

const renderFacilityRegions = (regions) => {
    const facilityAddressContainer = $("#facilityRegion");
    regions.forEach(region => {
        facilityAddressContainer.append(createRadioOption(region))
    })
}

const createRadioOption = (region) => {
    return `<option class="custom-control-label" value="${region.id}">${region.label}</option>`;
}


$(function(){

    var submitButton = $("#submitButton");

    $('.form-request').on('submit', function(ev) {
        var form = this;

        if (form.locked) {
            return;
        }

        // serialize form data to JSON
        let data = {
            contact: {
                email: this.contactEmail.value,
                name: this.contactName.value,
                phone: this.contactPhone.value
            },
            facility: {
                address: this.facilityAddress.value,
                name: this.facilityName.value,
                type: this.facilityType.value
            },
            items: {
                earSavers: parseInt(this.requestEarSavers.value) || 0,
                faceShieldFrames: parseInt(this.requestFaceShieldFrames.value) || 0,
                visors: parseInt(this.requestVisors.value) || 0
            },
            notes: this.additionalNotes.value || "",
            region: this.facilityRegion.value,
            urgency: parseInt(this.requestUrgency.value) || 1
        }

        console.log(data);
        form.locked = true;
        submitButton.attr('disabled', true);
        ev.preventDefault();

        $.ajax({
            type: 'POST',
            url: '{{ site.endpoints.hcp_submit }}',
            data: JSON.stringify(data),
            success: function(data) {
                console.log('Success.');
                window.location = form.action;
            },
            contentType: 'application/json',
            dataType: 'json'
        })
        .fail(function() {
            alert( "There was an error with your submission." );
            form.locked = false;
            submitButton.attr('disabled', false);
        });
    });
});
