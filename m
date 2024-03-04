Return-Path: <virtio-dev-return-14374-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D806AC48BF6
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Mar 2024 07:11:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1B4DA2AF82
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Mar 2024 07:11:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F2F50986394
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Mar 2024 07:11:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D62D8983D67; Mon,  4 Mar 2024 07:11:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C20D598633F
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Mar 2024 07:11:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <e2e5a7a0-7a2b-40d3-acf7-6f0b91bd5d40@quicinc.com>
Date: Mon, 4 Mar 2024 15:11:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Harald Mommer <Harald.Mommer@opensynergy.com>
CC: <quic_ztu@quicinc.com>, Matti Moell <Matti.Moell@opensynergy.com>,
        "Mikhail Golubev" <Mikhail.Golubev@opensynergy.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        "Mark Brown" <broonie@kernel.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
 <20240213135350.5878-4-Harald.Mommer@opensynergy.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20240213135350.5878-4-Harald.Mommer@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TRfS_aeVgQMiISkc-z98zurtH--oPIV3
X-Proofpoint-ORIG-GUID: TRfS_aeVgQMiISkc-z98zurtH--oPIV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_02,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1011 adultscore=0 spamscore=0 mlxlogscore=732 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040053
Subject: [virtio-dev] Re: [RFC PATCH v3 3/3] SPI: Add virtio SPI driver.



On 2/13/2024 9:53 PM, Harald Mommer wrote:
> +static struct spi_board_info board_info = {
> +	.modalias = "spi-virtio",
> +};

Hi Harald,
     Do you add "spi-virtio" in spidev_spi_ids in spidev.c when you 
doing the tests, to probe spidev driver?

Thanks

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

