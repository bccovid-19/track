---
---

const REGIONS_API_ENDPOINT = "https://www.qa.bcc3d.ca/api/v1/region";

window.onload = () => {
    fetch(REGIONS_API_ENDPOINT)
        .then((response) => {
            return response.json();
        })
        .then((data) => {
            renderFacilityRegions(data.regions)
        });
};

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
        var data = {
            facilityName: this.facilityName.value,
            facilityAddress: this.facilityAddress.value,
            facilityRegion: this.facilityRegion.value,
            contactName: this.contactName.value,
            contactPhone: this.contactPhone.value,
            contactEmail: this.contactEmail.value,
            requestFaceShieldFrames: parseInt(this.requestFaceShieldFrames.value) || 0,
            requestVisors: parseInt(this.requestVisors.value) || 0,
            requestEarSavers: parseInt(this.requestEarSavers.value) || 0,
            requestUrgency: parseInt(this.requestUrgency.value) || 1,
            facilityType: this.facilityType.value,
            additionalNotes: this.additionalNotes.value || ""
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