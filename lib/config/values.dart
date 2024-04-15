import 'dart:ui';

/// Constant values
const double tiny_25 = 1.0;
const double tiny_50 = 2.0; // divider value

const double small_50 = 4.0;
const double small_75 = 6.0;
const double small_100 = 8.0; // default padding

const double normal_100 = 16.0; // larger padding
const double normal_125 = 20.0;
const double normal_150 = 24.0;
const double normal_175 = 28.0;
const double normal_200 = 32.0;
const double normal_225 = 36.0;
const double normal_250 = 40.0;
const double normal_275 = 44.0;
const double normal_300 = 48.0;

const double large_100 = 32.0;
const double large_125 = 40.0;
const double large_150 = 48.0;
const double large_175 = 56.0;
const double large_200 = 64.0;

const double huge_100 = 96.0;
const double huge_200 = 128.0;
const double huge_250 = 160.0;
const double huge_300 = 192.0;
const double huge_350 = 224.0;
const double huge_400 = 256.0;

/// border radius
const Radius tinyRadius = Radius.circular(5);
const Radius innerBorderRadius = Radius.circular(8);
const Radius smallRadius = Radius.circular(10);
const Radius normalRadius = Radius.circular(16);
const Radius largeRadius = Radius.circular(24);

/// blur values
ImageFilter blurFilter =
    ImageFilter.blur(sigmaY: normal_100, sigmaX: normal_100);

/// animation duration
const Duration smallAnimationDuration = Duration(milliseconds: 200);
const Duration normalAnimationDuration = Duration(milliseconds: 400);
const Duration largeAnimationDuration = Duration(milliseconds: 800);
const Duration hugeAnimationDuration = Duration(milliseconds: 3200);

/// constants
const int MAX_ORDER_QUANTITY = 50;
const int MIN_SEARCH_DISTANCE = 2;
const int MAX_SEARCH_DISTANCE = 50;
//
Map<String, String> offersMap = {
  '1': 'amount',
  '2': 'percentage',
};
//hours
Map<String, String> hoursMap = {
  '1': '1 hour',
  '2': '2 hours',
  '3': '3 hours',
  '4': '4 hours',
  '5': '5 hours',
  '6': '6 hours',
  '7': '7 hours',
  '8': '8 hours',
  '9': '9 hours',
  '10': '10 hours',
  '11': '11 hours',
  '12': '12 hours',
  '13': '13 hours',
};
//product varaints ptions
Map<String, String> optionsMap = {
  '1': 'Size',
  '2': 'Color',
  '3': 'Material',
  '4': 'Style',
  '5': 'Other',
};
//days

Map<String, String> daysMap = {
  '1': '1 day',
  '2': '2 days',
  '3': '3 days',
  '4': '4 days',
  '5': '5 days',
  '6': '6 days',
  '7': '7 days',
  '8': '8 days',
  '9': '9 days',
  '10': '10 days',
  '11': '11 days',
  '12': '12 days',
  '13': '13 days',
  '14': '14 days',
  '15': '15 days',
  '16': '16 days',
  '17': '17 days',
  '18': '18 days',
  '19': '19 days',
  '20': '20 days',
  '21': '21 days',
  '22': '22 days',
  '23': '23 days',
  '24': '24 days',
  '25': '25 days',
  '26': '26 days',
  '27': '27 days',
  '28': '28 days',
  '29': '29 days',
  '30': '30 days',
};

/// Country list with CountryCode
const Map<String, String> countryList = {
  'AF': 'Afghanistan',
  'AL': 'Albania',
  'DZ': 'Algeria',
  'AD': 'Andorra',
  'AO': 'Angola',
  'AI': 'Anguilla',
  'AG': 'Antigua and Barbuda',
  'AR': 'Argentina',
  'AM': 'Armenia',
  'AU': 'Australia',
  'AT': 'Austria',
  'AZ': 'Azerbaijan',
  'BS': 'Bahamas',
  'BH': 'Bahrain',
  'BD': 'Bangladesh',
  'BB': 'Barbados',
  'BY': 'Belarus',
  'BE': 'Belgium',
  'BZ': 'Belize',
  'BJ': 'Benin',
  'BM': 'Bermuda',
  'BT': 'Bhutan',
  'BO': 'Bolivia',
  'BA': 'Bosnia and Herzegovina',
  'BW': 'Botswana',
  'BR': 'Brazil',
  'BN': 'Brunei Darussalam',
  'BG': 'Bulgaria',
  'BF': 'Burkina Faso',
  'BI': 'Burundi',
  'KH': 'Cambodia',
  'CM': 'Cameroon',
  'CA': 'Canada',
  'CV': 'Cape Verde',
  'CF': 'Central African Republic',
  'TD': 'Chad',
  'CL': 'Chile',
  'CN': 'China',
  'CO': 'Colombia',
  'KM': 'Comoros',
  'CG': 'Congo',
  'CD': 'Congo, The Democratic Republic of the',
  'CR': 'Costa Rica',
  'CI': 'Cote D\'Ivoire',
  'HR': 'Croatia',
  'CU': 'Cuba',
  'CY': 'Cyprus',
  'CZ': 'Czech Republic',
  'DK': 'Denmark',
  'DJ': 'Djibouti',
  'DM': 'Dominica',
  'DO': 'Dominican Republic',
  'EC': 'Ecuador',
  'EG': 'Egypt',
  'SV': 'El Salvador',
  'GQ': 'Equatorial Guinea',
  'ER': 'Eritrea',
  'EE': 'Estonia',
  'ET': 'Ethiopia',
  'FO': 'Faroe Islands',
  'FJ': 'Fiji',
  'FI': 'Finland',
  'FR': 'France',
  'GF': 'French Guiana',
  'GA': 'Gabon',
  'GM': 'Gambia',
  'GE': 'Georgia',
  'DE': 'Germany',
  'GH': 'Ghana',
  'GI': 'Gibraltar',
  'GR': 'Greece',
  'GD': 'Grenada',
  'GP': 'Guadeloupe',
  'GT': 'Guatemala',
  'GN': 'Guinea',
  'GW': 'Guinea-Bissau',
  'GY': 'Guyana',
  'HT': 'Haiti',
  'HM': 'Heard Island and Mcdonald Islands',
  'VA': 'Holy See (Vatican City State)',
  'HN': 'Honduras',
  'HK': 'Hong Kong',
  'HU': 'Hungary',
  'IS': 'Iceland',
  'IN': 'India',
  'ID': 'Indonesia',
  'IR': 'Iran, Islamic Republic Of',
  'IQ': 'Iraq',
  'IE': 'Ireland',
  'IM': 'Isle of Man',
  'IT': 'Italy',
  'JM': 'Jamaica',
  'JP': 'Japan',
  'JE': 'Jersey',
  'JO': 'Jordan',
  'KZ': 'Kazakhstan',
  'KE': 'Kenya',
  'KI': 'Kiribati',
  'KP': 'Korea, Democratic People\'S Republic of',
  'KR': 'Korea, Republic of',
  'KW': 'Kuwait',
  'KG': 'Kyrgyzstan',
  'LA': 'Lao People\'S Democratic Republic',
  'LV': 'Latvia',
  'LB': 'Lebanon',
  'LS': 'Lesotho',
  'LR': 'Liberia',
  'LY': 'Libyan Arab Jamahiriya',
  'LI': 'Liechtenstein',
  'LT': 'Lithuania',
  'LU': 'Luxembourg',
  'MO': 'Macao',
  'MK': 'Macedonia, The Former Yugoslav Republic of',
  'MG': 'Madagascar',
  'MW': 'Malawi',
  'MY': 'Malaysia',
  'MV': 'Maldives',
  'ML': 'Mali',
  'MT': 'Malta',
  'MH': 'Marshall Islands',
  'MQ': 'Martinique',
  'MR': 'Mauritania',
  'MU': 'Mauritius',
  'YT': 'Mayotte',
  'MX': 'Mexico',
  'FM': 'Micronesia, Federated States of',
  'MD': 'Moldova, Republic of',
  'MC': 'Monaco',
  'MN': 'Mongolia',
  'MS': 'Montserrat',
  'MA': 'Morocco',
  'MZ': 'Mozambique',
  'MM': 'Myanmar',
  'NA': 'Namibia',
  'NR': 'Nauru',
  'NP': 'Nepal',
  'NL': 'Netherlands',
  'AN': 'Netherlands Antilles',
  'NC': 'New Caledonia',
  'NZ': 'New Zealand',
  'NI': 'Nicaragua',
  'NE': 'Niger',
  'NG': 'Nigeria',
  'NU': 'Niue',
  'NF': 'Norfolk Island',
  'MP': 'Northern Mariana Islands',
  'NO': 'Norway',
  'OM': 'Oman',
  'PK': 'Pakistan',
  'PW': 'Palau',
  'PS': 'Palestine',
  'PA': 'Panama',
  'PG': 'Papua New Guinea',
  'PY': 'Paraguay',
  'PE': 'Peru',
  'PH': 'Philippines',
  'PN': 'Pitcairn',
  'PL': 'Poland',
  'PT': 'Portugal',
  'PR': 'Puerto Rico',
  'QA': 'Qatar',
  'RE': 'Reunion',
  'RO': 'Romania',
  'RU': 'Russian Federation',
  'RW': 'Rwanda',
  'WS': 'Samoa',
  'SM': 'San Marino',
  'ST': 'Sao Tome and Principe',
  'SA': 'Saudi Arabia',
  'SN': 'Senegal',
  'CS': 'Serbia and Montenegro',
  'SC': 'Seychelles',
  'SL': 'Sierra Leone',
  'SG': 'Singapore',
  'SK': 'Slovakia',
  'SI': 'Slovenia',
  'SO': 'Somalia',
  'ZA': 'South Africa',
  'ES': 'Spain',
  'LK': 'Sri Lanka',
  'SD': 'Sudan',
  'SR': 'Suriname',
  'SZ': 'Swaziland',
  'SE': 'Sweden',
  'CH': 'Switzerland',
  'SY': 'Syrian Arab Republic',
  'TW': 'Taiwan',
  'TJ': 'Tajikistan',
  'TZ': 'Tanzania',
  'TH': 'Thailand',
  'TG': 'Togo',
  'TO': 'Tonga',
  'TT': 'Trinidad and Tobago',
  'TN': 'Tunisia',
  'TR': 'Turkey',
  'TM': 'Turkmenistan',
  'TV': 'Tuvalu',
  'UG': 'Uganda',
  'UA': 'Ukraine',
  'AE': 'United Arab Emirates',
  'GB': 'United Kingdom',
  'US': 'United States',
  'UY': 'Uruguay',
  'UZ': 'Uzbekistan',
  'VE': 'Venezuela',
  'VN': 'Vietnam',
  'EH': 'Western Sahara',
  'YE': 'Yemen',
  'ZM': 'Zambia',
  'ZW': 'Zimbabwe'
};
Map<String, String> percentageValues = {
  '10': '10%',
  '20': '20%',
  '30': '30%',
  '40': '40%',
  '50': '50%',
  '60': '60%',
  '70': '70%',
  '80': '80%',
  '90': '90%',
};

List<String> Day = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday",
];
