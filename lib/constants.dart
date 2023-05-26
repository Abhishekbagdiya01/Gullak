class Constants {
  
  static const mapMonth = {
    '01': 'Jan',
    '02': 'Feb',
    '03': 'March',
    '04': 'APR',
    '05': 'May',
    '06': 'Jun',
    '07': 'July',
    '08': 'Aug',
    '09': 'Sep',
    '10': 'Oct',
    '11': 'Nov',
    '12': 'Dec',
  };

  static const imagePathCafe = "assets/expense_types_icons/cafe.png";
  static const imagePathBooks = "assets/expense_types_icons/books.png";
  static const imagePathFastFood = "assets/expense_types_icons/fast-food.png";
  static const imagePathMakeUps = "assets/expense_types_icons/cosmetics.png";
  static const imagePathGames =
      "assets/expense_types_icons/game-controller.png";
  static const imagePathMovie = "assets/expense_types_icons/movie.png";
  static const imagePathShopping = "assets/expense_types_icons/shopping.png";
  static const imagePathTravels = "assets/expense_types_icons/travel.png";
  static const imagePathGym = "assets/expense_types_icons/gym.png";
  static const imagePathRestaurant =
      "assets/expense_types_icons/restaurant.png";
  static const imagePathGroceries = "assets/expense_types_icons/grocery.png";
  static const imagePathAccessories =
      "assets/expense_types_icons/accessories.png";

  static const expensesList = [
    {
      'id': 1,
      'image': imagePathCafe,
    },
    {
      'id': 2,
      'image': imagePathBooks,
    },
    {
      'id': 3,
      'image': imagePathFastFood,
    },
    {
      'id': 4,
      'image': imagePathMakeUps,
    },
    {
      'id': 5,
      'image': imagePathGames,
    },
    {
      'id': 6,
      'image': imagePathMovie,
    },
    {
      'id': 7,
      'image': imagePathShopping,
    },
    {
      'id': 8,
      'image': imagePathTravels,
    },
    {
      'id': 9,
      'image': imagePathGym,
    },
    {
      'id': 10,
      'image': imagePathGroceries,
    },
    {
      'id': 11,
      'image': imagePathAccessories,
    },
  ];
  static const allTransactions = [
    {
      'day': 'Today',
      'amt': '7.24',
      'transactions': [
        {
          'id': 1,
          'image': imagePathCafe,
          'title': 'Cafe',
          'desc': 'with friends',
          'amt': '300.0',
          'balance': '700.0'
        },
        {
          'id': 2,
          'image': imagePathAccessories,
          'title': 'Watch',
          'desc': 'Titan watch',
          'amt': '300.0',
          'balance': '700.0'
        },
      ]
    },
    {
      'day': '25th Sep',
      'amt': '77.34',
      'transactions': [
        {
          'id': 11,
          'image': imagePathAccessories,
          'title': 'Belt',
          'desc': 'Woodland belt',
          'amt': '699.0',
          'balance': '1500.0'
        },
        {
          'id': 12,
          'image': imagePathMovie,
          'title': 'The shawshank redemption',
          'desc': 'with friends',
          'amt': '349.0',
          'balance': '1900.0'
        }
      ]
    },
    {
      'day': 'Yesterday',
      'amt': '7.24',
      'transactions': [
        {
          'id': 7,
          'image': imagePathFastFood,
          'title': 'Cafe',
          'desc': 'with friends',
          'amt': '300.0',
          'balance': '700.0'
        },
        {
          'id': 1,
          'image': imagePathRestaurant,
          'title': 'Restaurant',
          'desc': 'with family',
          'amt': '300.0',
          'balance': '700.0'
        },
        {
          'id': 2,
          'image': imagePathGames,
          'title': 'Cs:go',
          'desc': 'with squad',
          'amt': '300.0',
          'balance': '700.0'
        },
      ]
    },
    {
      'day': '30th Aug',
      'amt': '7.24',
      'transactions': [
        {
          'id': 3,
          'image': imagePathBooks,
          'title': 'A song of fire and ice',
          'desc': 'Novel',
          'amt': '300.0',
          'balance': '700.0'
        },
        {
          'id': 4,
          'image': imagePathGroceries,
          'title': 'Groceries items',
          'desc': 'for room',
          'amt': '300.0',
          'balance': '700.0'
        },
        {
          'id': 5,
          'image': imagePathShopping,
          'title': 'Shoes',
          'desc': 'Adidas supernova',
          'amt': '300.0',
          'balance': '700.0'
        },
        {
          'id': 6,
          'image': imagePathMovie,
          'title': 'Black panther',
          'desc': 'with friends',
          'amt': '300.0',
          'balance': '700.0'
        },
      ]
    },
    {
      'day': '29th Aug',
      'amt': '7.24',
      'transactions': [
        {
          'id': 1,
          'image': imagePathTravels,
          'title': 'Ladhak',
          'desc': 'for bike track',
          'amt': '300.0',
          'balance': '700.0'
        },
        {
          'id': 2,
          'image': imagePathShopping,
          'title': 'Jacket',
          'desc': 'Monte carlo',
          'amt': '300.0',
          'balance': '700.0'
        },
      ]
    },
  ];
}
