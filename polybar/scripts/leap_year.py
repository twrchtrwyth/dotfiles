def leap_year(year):
    """Checks to see if a year is a leap year."""
    if year % 4 == 0:  # Years divisible by 4 are leap years
        if year % 100 == 0:  # Unless also divisible by 100
            if year % 400 == 0:  # Except if also divisible by 400
                return True
            return False
        return True
    return False
