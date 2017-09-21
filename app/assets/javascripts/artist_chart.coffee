# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class ArtistChart

  addRecordsPerYear: ->
    ctx = document.getElementById("records-per-year")
    chart = new Chart(
      ctx,
      {
        type: 'bar'
        data:
          labels: JSON.parse(ctx.dataset.years)
          datasets: [
            label: 'Number of Records Per Year'
            data: JSON.parse(ctx.dataset.recordsPerYear)
            backgroundColor: [
              'rgba(0, 128, 128, 0.2)',
              'rgba(255, 99, 132, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(255, 206, 86, 0.2)',
              'rgba(75, 192, 192, 0.2)',
              'rgba(153, 102, 255, 0.2)',
              'rgba(255, 159, 64, 0.2)'
              'rgba(154, 205, 50, 0.2)'
            ]
            borderColor: [
              'rgba(0, 128, 128, 1)',
              'rgba(255,99,132,1)',
              'rgba(54, 162, 235, 1)',
              'rgba(255, 206, 86, 1)',
              'rgba(75, 192, 192, 1)',
              'rgba(153, 102, 255, 1)',
              'rgba(255, 159, 64, 1)',
              'rgba(154, 205, 50, 1)'
            ]
            borderWidth: 1
          ]
        options:
          scales:
            yAxes: [
              ticks:
                beginAtZero: true
                # stepSize: 2 this is kinda of cool but the graph tool hanldes this way better
            ]
      }
    )

document.addEventListener 'turbolinks:load', ->
  new ArtistChart().addRecordsPerYear()