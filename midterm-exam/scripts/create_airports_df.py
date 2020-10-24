import json
import pandas as pd


if __name__ == "__main__":
    with open('../utility_dataframes/airports.json') as file:
        airports = json.load(file)

    airports_df = pd.DataFrame(airports, columns=['code', 'city', 'country'])

    # add lacking airports
    lacking_airports = [
    	{'code': 'OHH', 'city': 'Okha', 'country': 'Russia'},
    	{'code': 'NGK', 'city': 'Nogliki-Sakhalin', 'country': 'Russia'},
    	{'code': 'OHH', 'city': 'Okha', 'country': 'Russia'},
	    {'code': 'NGK', 'city': 'Nogliki-Sakhalin', 'country': 'Russia'},
	    {'code': 'SAR', 'city': 'Sparta', 'country': 'United States'},
	    {'code': 'SKX', 'city': 'Taos', 'country': 'United States'},
	    {'code': 'VDH', 'city': 'Dong Hoi', 'country': 'Vietnam'},
	    {'code': 'OVA', 'city': 'Bekily', 'country': 'Madagascar'},
	    {'code': 'VCA', 'city': 'Ha Noi', 'country': 'Vietnam'},
	    {'code': 'NIA', 'city': 'Nimba', 'country': 'Liberia'},
	    {'code': 'HIA', 'city': 'Huaian', 'country': 'China'},
	    {'code': 'BPL', 'city': 'Bole', 'country': 'China'},
	    {'code': 'TLQ', 'city': 'Turpan', 'country': 'China'},
	    {'code': 'KNO', 'city': 'Knokke-Heist', 'country': 'Belgium'},
	    {'code': 'TNH', 'city': 'Tonghua', 'country': 'China'},
	    {'code': 'JGD', 'city': 'Jiagedaqi', 'country': 'China'},
	    {'code': 'BFJ', 'city': 'Ba', 'country': 'Fiji'},
	    {'code': 'NBS', 'city': 'Baishan', 'country': 'China'},
	    {'code': 'ULH', 'city': 'Al Ula', 'country': 'Saudi Arabia'},
	    {'code': 'NJF', 'city': 'Najaf', 'country': 'Iraq'},
	    {'code': 'TCG', 'city': 'Tacheng', 'country': 'China'},
	    {'code': 'YZY', 'city': 'Zhangye', 'country': 'China'},
	    {'code': 'YUS', 'city': 'Yushu', 'country': 'China'},
	    {'code': 'BPE', 'city': 'Bagan', 'country': 'Burma'},
	    {'code': 'THD', 'city': 'Sao Vang', 'country': 'Vietnam'},
	    {'code': 'AOG', 'city': 'Anshan', 'country': 'China'},
    ]

    lacking_airports_df = pd.DataFrame(lacking_airports)

    airports_df = pd.concat((airports_df, lacking_airports_df), ignore_index=True)

    airports_df.to_csv('../utility_dataframes/airports_df.csv')