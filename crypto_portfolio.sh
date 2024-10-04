#!/usr/bin/env bash
#
#
#		Crypto Protfolio
#
#
#			Install			sudo apt install curl jq
#
#			chmod				chmod +x crypto_portfolio.sh
#
#			Assets			set var <asset> and <amount>
#
#			run				./crypto_portfolio.sh
#
#			API				kucoin.com
#
#


# Assets / Amount
		asset=(  "BTC" "ETH" "XTZ"   "XMR" )
		amount=( "2"   "20"  "20000" "200" )


# Function
	crypto_portfolio() {
		clear
		RED='\033[0;31m'
		MAG='\033[35m'
		NC='\033[0m'
		i=-1
		total=0
      echo -e -n "\n\n\tCrypto Portfolio\n\n\n"
		echo -e -n "${RED}\t\tAsset\tAmount\tPrice $\t\tSubtotal $\n"
		echo -e -n "\t\t___________________________________________\n\n${NC}"
      for a in "${asset[@]}"
      do
			i=$(($i+1))
         price=$(curl -s -H -X GET 'https://api.kucoin.com/api/v1/market/orderbook/level1?symbol='$a'-USDT' | jq -r '.data.price')
			subtotal=$(echo "($price*${amount[$i]})" | bc -l | sed -r 's/([^\.]*)\..*/\1/' )
			total=$(($total+$subtotal))
			echo -e -n "\t\t$a\t${amount[$i]}\t$price\t\t$subtotal\n"
      done
		echo -e -n "${RED}\n\t\t___________________________________________\n\n${NC}"
		echo -e -n "${MAG}\t\tTotal\t$total \$\n${NC}"
		echo -e -n "${RED}\t\t==================\n\n\n${NC}"
		read dummy
		clear
   }
   crypto_portfolio



# END
#
#


