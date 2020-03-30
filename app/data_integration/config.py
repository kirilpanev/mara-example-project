"""Project specific data integration settings"""


def dev_limit() -> bool:
    """Whether or not to return less data (e.g. LIMIT 1000) when no time limit is available"""
    return ''


def number_of_chunks() -> int:
    return 7
