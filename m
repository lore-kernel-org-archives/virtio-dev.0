Return-Path: <virtio-dev-return-14144-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D6EC4332F
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Dec 2023 06:54:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2B62494EF8
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Dec 2023 06:54:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 186099866DD
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Dec 2023 06:54:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0AC619866B0; Wed, 13 Dec 2023 06:54:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA02498669C;
	Wed, 13 Dec 2023 06:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <67c474f3-30a5-4040-9535-e96d8fd4c7ee@quicinc.com>
Date: Wed, 13 Dec 2023 14:54:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <cohuck@redhat.com>
CC: <quic_ztu@quicinc.com>,
        "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>,
        Harald Mommer <harald.mommer@opensynergy.com>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        Mark Brown <broonie@kernel.org>
References: <20231212033317.22198-1-quic_haixcui@quicinc.com>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20231212033317.22198-1-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dlFGRJ4WxY4nreukiOBfWQBGQbEQJ6hk
X-Proofpoint-GUID: dlFGRJ4WxY4nreukiOBfWQBGQbEQJ6hk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxlogscore=678 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312130049
Subject: Re: [virtio-dev][PATCH V9 0/2] virtio-spi: add virtual SPI controller

Hi Cornelia,

     In patch V9, all comments have been fixed. Could you please help to 
review the new patch. And if there are no other comments, can you help 
to merge it as the initial version of virtio-spi. Thank you so much for 
your support.

Thanks
Haixu Cui

On 12/12/2023 11:33 AM, Haixu Cui wrote:
> The Virtio SPI (Serial Peripheral Interface) device is a virtual SPI controller that
> allows the driver to operate and use the SPI controller under the control of the host,
> either a physical SPI controller, or an emulated one.
> 
> Patch summary:
> patch 1 rename virtual SPI device name
> patch 2 add the specification for virtio-spi
> 
> Haixu Cui (2):
>    content: Rename SPI master to SPI controller
>    virtio-spi: add the device specification
> 
>   content.tex                             |   3 +-
>   device-types/spi/description.tex        | 281 ++++++++++++++++++++++++
>   device-types/spi/device-conformance.tex |   7 +
>   device-types/spi/driver-conformance.tex |   7 +
>   4 files changed, 297 insertions(+), 1 deletion(-)
>   create mode 100644 device-types/spi/description.tex
>   create mode 100644 device-types/spi/device-conformance.tex
>   create mode 100644 device-types/spi/driver-conformance.tex
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

