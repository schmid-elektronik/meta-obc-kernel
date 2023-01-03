import argparse

class CmdArgs:
    """commandline arguments"""

    def __init__(self):
        self.cmdargs = {
            "outfile": "",
            "errorfile": "",   
            "obc_sn": "",
            "bb_sn": "",
            "interval": ""
        }

        parser = argparse.ArgumentParser(description='''GET obc configuration and store to inifile 
            call eg: python3 configService.py --bb 58 --obc 58 --errorfile obd_error.json --outfile obc.cnf --interval 10''')

        parser.add_argument('--interval',
                            dest='interval',
                            type=int,
                            default=0,
                            help='request interval in sec, 0 for just once')

        parser.add_argument('--bb',
                            dest='sn_bb',
                            type=int,
                            default=1,
                            help='backbone serial number')

        parser.add_argument('--obc',
                            dest='sn_obc',
                            type=int,
                            default=1,
                            help='obc serial number')

        parser.add_argument('--outfile',
                            dest='outfile',
                            type=str,
                            default='./obc.cnf',
                            help='obc config file')

        parser.add_argument('--errorfile',
                            dest='errorfile',
                            type=str,
                            default='./obd_error.json',
                            help='obd error description file')

        args = parser.parse_args()

        self.cmdargs['errorfile'] = args.errorfile
        self.cmdargs['outfile'] = args.outfile
        self.cmdargs['sn_obc'] = args.sn_obc
        self.cmdargs['sn_bb'] = args.sn_bb
        self.cmdargs['interval'] = args.interval

    def get_available_options(self):
        """Returns list of available options"""
        return self.cmdargs.keys()

    def getval(self, param):
        """returns parameter"""
        return self.cmdargs[param]
