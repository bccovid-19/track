$(function(){

    console.log('Ready!');
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

        // post it up.
        var jqxhr = $.post( "https://track.bcc3d.ca/hcp/submit", function() {
            console.log('Success.')
        })
        .done(function() {
            window.location = form.action;
        })
        .fail(function() {
            alert( "There was an error with your submission." );
        });
    })
});