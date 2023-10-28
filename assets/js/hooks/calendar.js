import flatpickr from '../../vendor/flatpickr';

export default Calendar = {
	mounted(){
		this.pickr = flatpickr(this.el, {
			inline: true,
			mode: "range",
			showMonths: 2,
			disable: JSON.parse(this.el.dataset.unavailableDates),
			onChange: (selectedDates) => {
				if (selectedDates.length!= 2) return;
				this.pushEvent("dates-picked", selectedDates)
			}
		})

		this.handleEvent("add-unavailable-dates", (dates) => {
			this.pickr.set("disable", [dates, ...this.pickr.config.disable])
		})
	},
	destroyed(){
		this.pickr.destroyed()
	}
}

