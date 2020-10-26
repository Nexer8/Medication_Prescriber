const String apiUrl = 'http://medicationprescriberapi.azurewebsites.net/';
const String doctorsEndpoint = 'api/doctors';
const String medicationsEndpoint = 'api/medications';
const String patientsEndpoint = 'api/patients';

const int error = -1;
const int noError = 0;

enum MedicationTiming { Irrelevant, BeforeEating, AfterEating }
