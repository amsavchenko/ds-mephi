const fs = require('fs');

const timeFlight = new Map();

const timeFlightParser = async () => {
  let firstStringFNT = 'FlightNumber,Time\n';

  const data = await fs.promises.readFile('tab_processed.csv', 'utf8');
  const allFlights = data.split('\n').slice(1, -2);
  allFlights.forEach((flight) => {
    const splittedFlight = flight.split(',');
    timeFlight.set(splittedFlight[6].slice(0, 6), splittedFlight[3]);
  });

  const data2 = await fs.promises.readFile('boarding_data_processed.csv', 'utf8');
  const allFlights2 = data2.split('\n').slice(1, -1);
  allFlights2.forEach((flight) => {
    const splittedFlight = flight.split(',');
    timeFlight.set(splittedFlight[12], splittedFlight[11]);
  });

  const data3 = await fs.promises.readFile('excel_df_correct_names.csv', 'utf8');
  const allFlights3 = data3.split('\n').slice(1, -1);
  allFlights3.forEach((flight) => {
    const splittedFlight = flight.split(',');
    timeFlight.set(splittedFlight[4], splittedFlight[6]);
  });

  timeFlight.forEach((time, flightNumber) => {
    firstStringFNT = firstStringFNT.concat(`${flightNumber},${time}\n`)
  })

  await fs.promises.writeFile('FlightNumberTime.csv', firstStringFNT, 'utf8');
}



const jsonParser = async () => {
  const data = await fs.promises.readFile('FrequentFlyerForum-Profiles.json', 'utf8');

  const result = JSON.parse(data);
  await timeFlightParser();

  let firstString = 'FirstName,LastName,Gender,' +
    'FlightNumber,Date,Time,' +
    'DepartureCountry,DepartureCity,DepartureAirport,' +
    'ArrivalCountry,ArrivalCity,ArrivalAirport,AirlineName,LoyaltyStatus\n'

  result["Forum Profiles"].forEach((profile) => {
    const name = profile["Real Name"];
    const gender = profile["Sex"];
    const flights = profile["Registered Flights"]
    const loyalty = profile["Loyality Programm"];

    const newSting = `${name["First Name"] || ''},${name["Last Name"] || ''},${gender},`;

    flights.forEach((flight) => {
      const departure = flight["Departure"];
      const departureCity = departure["Country"] === "United States of" ? departure["City"].slice(0, -3) : departure["City"];
      const arrival = flight["Arrival"];

      const newFlight = `${flight["Flight"]},${flight["Date"]},${timeFlight.get(flight["Flight"]) || ''},`;
      const newDeparture = `${departure["Country"]},${departureCity},${departure["Airport"]},`;
      const newArrival = `${arrival["Country"]},${arrival["City"]},${arrival["Airport"]},`;

      let loyaltyStatus = '\n';
      const testLoyalty = flight["Flight"].match(/^\w{2}/);
      loyalty.forEach((loyalty) => {
        if (testLoyalty[0] === loyalty["programm"]) {
          loyaltyStatus = `${loyalty["programm"]}${loyalty["Number"]}\n`;
        }
      })

      firstString = firstString.concat(newSting, newFlight, newDeparture, newArrival, loyaltyStatus);
    })
  })

  await fs.promises.writeFile('FrequentFlyerForum-Profiles.csv', firstString, 'utf8')
}

jsonParser();
