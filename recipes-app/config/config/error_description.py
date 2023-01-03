import requests

class ErrorDescription:
    """
    get Error description JSON
    write it to file
    """

    def __init__(self, error_url, outfile):
        # get obd Json Error Description
        if not error_url:
            return

        # get Error description
        try:
            r = requests.get(error_url)
        except Exception as e:
            print('GET failed from url: ' + error_url)
            return

        ## check HTTP response, check if valid JSON received
        try:
            r.raise_for_status()
            r.json()
        except Exception as e:
            print('No JSON at url: ' + error_url)
            print('Status code: ' + str(r.status_code))
            return

        with open(outfile, 'w') as f:
            f.write(r.text)
