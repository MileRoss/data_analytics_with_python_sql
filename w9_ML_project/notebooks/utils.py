# Define a decorator to measure the runtime of functions

from time import time

def timer(func):
    def wrapper(*args, **kwargs):
        start_time = time()
        result = func(*args, **kwargs)
        end_time = time()
        runtime = int(end_time - start_time)
        return result, runtime
    return wrapper