const String apiUrl = 'http://medicationprescriberapi.azurewebsites.net/';
const String doctorsEndpoint = 'api/doctors';
const String medicationsEndpoint = 'api/medications';
const String patientsEndpoint = 'api/patients';
const String endDateTime = 'T23:59:59.000Z';

enum MedicationTiming { Irrelevant, BeforeEating, AfterEating }
