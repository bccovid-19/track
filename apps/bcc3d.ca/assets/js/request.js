$(function(){

    $('.form-request').on('submit', function(ev) {

        var form = this;
        ev.preventDefault();

        // serialize form data to JSON
        var data = {
            facilityName: this.facilityName.value,
            facilityAddress: this.facilityAddress.value,
            contactName: this.contactName.value,
            contactPhone: this.contactPhone.value,
            requestFaceShieldFrames: this.requestFaceShieldFrames.value,
            requestVisors: this.requestVisors.value,
            requestEarSavers: this.requestEarSavers.value,
            requestUrgency: this.requestUrgency.value,
            facilityType: this.facilityType.value,
        }

        console.log(data);

        $.ajax({
            type: 'POST',
            url: 'https://qa.track.bcc3d.ca/hcp/submit',
            data: JSON.stringify(data),
            success: function(data) {
                console.log('Success.')
                window.location = form.action;
            },
            contentType: 'application/json',
            dataType: 'json'
        })
        .fail(function() {
            alert( "There was an error with your submission." );
        });

    });
});