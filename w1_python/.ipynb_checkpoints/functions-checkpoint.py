def get_unique_list_f(lst):
    """
    Takes a list as an argument and returns a new list with unique elements from the first list.

    Parameters:
    lst (list): The input list.

    Returns:
    list: A new list with unique elements from the input list.
    """
    unique_list = list(set(lst))  # Convert the list to a set to remove duplicates, then back to a list
    return unique_list

# Example usage with the given example
# example_list = [1, 2, 3, 3, 3, 3, 4, 5]
# unique_list = get_unique_list_f(example_list)
# print("Unique list:", unique_list)  # Expected Output: [1, 2, 3, 4, 5]

def count_case_f(string):
    """
    Returns the number of uppercase and lowercase letters in the given string.

    Parameters:
    string (str): The string to count uppercase and lowercase letters in.

    Returns:
    A tuple containing the count of uppercase and lowercase letters in the string.
    """
    upper = 0
    lower = 0
    
    for i in string:
        if i.isupper():
            upper += 1
        elif i.islower():
            lower += 1

    print("Uppercase count:", upper, "Lowercase count:", lower)
    return upper, lower

# Example usage
# count_case_f("Hello World")

import string

def remove_punctuation_f(sentence):
    """
    Removes all punctuation marks (commas, periods, exclamation marks, question marks) from a sentence.

    Parameters:
    sentence (str): A string representing a sentence.

    Returns:
    str: The sentence without any punctuation marks.
    """
    for char in sentence:
        if char in string.punctuation:
            sentence = sentence.replace(char, "")

    return sentence

# Example usage
# remove_punctuation_f("Sentence! here.")

def word_count_f(sentence):
    """
    Counts the number of words in a given sentence. To do this properly, first it removes punctuation from the sentence.
    Note: A word is defined as a sequence of characters separated by spaces. We can assume that there will be no leading or trailing spaces in the input sentence.
    
    Parameters:
    sentence (str): A string representing a sentence.

    Returns:
    int: The number of words in the sentence.
    """
    sentence = remove_punctuation_f(sentence)
    words = sentence.split()
    count = len(words)
    print(words)
    return count


# Example usage
# word_count_f("Note : this is an example !!! Good day : )")