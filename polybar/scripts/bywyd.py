#!/usr/bin/env python3
"""
-----
BYWYD
-----

Diolch I Joseph Hallenbeck am ei calendr `Pythefnos`, ac hefyd i'r
`International Fixed Calendar`.

Bydd calendr Bywyd yn dechrau a gorffen ar fy mhenblwydd bob blwyddyn. Mae bob
blwyddyn wedi rhannu i mewn i dau ddeg chwech pythefnos. Bydd rhain yn cael eu
gynrychioli gan lythyrau'r wyddor Lladin. Bydd bob diwrnod o fewn bob
bythefnos wedi cynrychioli gan rhif o un i un deg pedwar.

Dyw'r penblwyddi ddim yn cyfri fel diwrnod yn y calendr. Y diwrnod cyntaf o'r
flwyddyn, felly, yw'r 18ed o Ebrill. Nid yw diwrnodau naid yn cyfri chwaith.

---

Based on the Pythefnos calendar by Joseph Hallenbeck and on the International
Fixed Calendar. Thanks to Pythefnos, I decided to program this in Welsh.

Birthday is a day outside the calendar. This will be represented by a 0. Day 1
of each year is thus the 18th of April.
For leap years, I will ignore the leap day. This means I can just plough on
with my calculations just as they are below, and have the leap day as an
additional ignored day, just after my birthday.

The bywyd year will begin with how old I am, in years.
The year will be split into 26 fortnights, labelled A-Z.
The days in each fortnight will be numbered 1-14.
The format will be {age}{fortnight}{day}.
"""
import datetime
from leap_year import leap_year

# CYMRU AM BYTH
dangos = print

def cyfrifo_oedran(heddiw):
    """Cyfrifo a dychwelyd oedran i'r blwyddyn llawn agosaf."""
    if (heddiw.month, heddiw.day) <= (4, 16):
        oedran = heddiw.year - 1991 - 1
    elif (heddiw.month, heddiw.day) >= (4, 17):
        oedran = heddiw.year - 1991
    return oedran

def nol_diwrnod_y_flwyddyn(oedran, heddiw):
    """Dychwelyd sawl diwrnod o'r flwyddyn (yn dechrau o'r 17fed o Ebrill) sydd
    wedi mynd heibio, yn anwybyddu pob penblwydd a diwrnodau naid.
    """
    penblwydd = datetime.date(heddiw.year, 4, 17)
    diwrnod_y_flwyddyn = heddiw - penblwydd
    if str(diwrnod_y_flwyddyn)[0] == "-":
        diwrnod_y_flwyddyn += datetime.timedelta(days=365)
        if leap_year(heddiw.year):
            if (heddiw.month, heddiw.day) >= (3, 1):
                if (heddiw.month, heddiw.day) <= (4, 16):
                    return diwrnod_y_flwyddyn.days - 1
            return diwrnod_y_flwyddyn.days
    return diwrnod_y_flwyddyn.days - 1

def nol_pythefnos(diwrnod_y_flwyddyn):
    """Dychwelyd sawl pythefnos sydd wedi mynd heibio ers 17fed o Ebrill
    diwethaf.
    """
    pythefnos = (diwrnod_y_flwyddyn // 14) + 1
    return pythefnos

def nol_lythyren(pythefnos):
    """
    Dychwelyd y lythyren sy'n cyfateb i'r pythefnos bresennol e.e. pythefnos
    A = 1, pythefnos B = 2, a.a.
    """
    llythyren = chr(pythefnos + 64)
    return llythyren

def nol_diwrnod_y_pythefnos(diwrnod_y_flwyddyn):
    """Dychwelyd sawl ddiwrnod o'r pythefnos sydd wedi mynd heibio, o 1 i 14.
    """
    diwrnod_y_pythefnos = round((diwrnod_y_flwyddyn % 14) + 1)
    # Os mae `diwrnod` yn llai na deg, ychwanegu sero cyn y rhif.
    diwrnod_y_pythefnos = str(diwrnod_y_pythefnos).zfill(2)
    return diwrnod_y_pythefnos

def creu_dyddiad(heddiw, oedran, llythyren, diwrnod_y_pythefnos):
    """Dychwelyd y dyddiad mewn fformat `Bywyd`."""
    if (heddiw.month, heddiw.day) == (4, 17):
        return f"{oedran}*00"
    elif (heddiw.month, heddiw.day) == (2, 29):
        return f"{oedran}*01"
    else:
        return f"{oedran}{llythyren}{diwrnod_y_pythefnos}"

def prif():
    heddiw = datetime.date.today()
    oedran = cyfrifo_oedran(heddiw)
    diwrnod_y_flwyddyn = nol_diwrnod_y_flwyddyn(oedran, heddiw)
    pythefnos = nol_pythefnos(diwrnod_y_flwyddyn)
    llythyren = nol_lythyren(pythefnos)
    diwrnod_y_pythefnos = nol_diwrnod_y_pythefnos(diwrnod_y_flwyddyn)
    dyddiad = creu_dyddiad(heddiw, oedran, llythyren, diwrnod_y_pythefnos)
    dangos(dyddiad)

if __name__ == "__main__":
    prif()
