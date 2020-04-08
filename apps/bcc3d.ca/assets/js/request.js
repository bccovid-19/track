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
            requestFaceShieldFrames: parseInt(this.requestFaceShieldFrames.value) || 0,
            requestVisors: parseInt(this.requestVisors.value) || 0,
            requestEarSavers: parseInt(this.requestEarSavers.value) || 0,
            requestUrgency: parseInt(this.requestUrgency.value) || 1,
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