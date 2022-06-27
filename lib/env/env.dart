const String BASE_URL = "https://e-gov-ms-unot7.ondigitalocean.app/";

const String URL_LOGIN = BASE_URL + "api/user/authenticate";
const String URL_REGISTER = BASE_URL + "api/user/citizen/register";
const String URL_CREATE_COMPLAIN = BASE_URL + "api/user/citizen/complain";
const String URL_GET_COMPLAIN = BASE_URL + "api/user/gov/complains";
const String URL_SHARE_COMPLAIN = BASE_URL + "api/user/gov/share_complain";
const String URL_FEEDBACK_APPROVE_COMPLAIN = BASE_URL + "api/user/gov/approve";
const String URL_FEEDBACK_COMPLAIN = BASE_URL + "api/user/supervisor/feedback/";

const String CITIZEN = "ROLE_CITIZEN";
const String GOV_WORKER = "ROLE_GOV_WORKER";
const String SUPERVISOR = "ROLE_SUPERVISOR";
const String ADMIN = "ROLE_ADMIN";
