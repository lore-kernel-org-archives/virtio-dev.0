Return-Path: <virtio-dev-return-14109-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4066C4167B
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Dec 2023 02:30:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 31A503E575
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Dec 2023 02:30:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1E0B8986413
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Dec 2023 02:30:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 12B99986377; Mon,  4 Dec 2023 02:30:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02677986376;
	Mon,  4 Dec 2023 02:30:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <daee943c-1dfa-4c9a-85cf-8170ffbc1956@quicinc.com>
Date: Mon, 4 Dec 2023 10:30:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <virtio-dev@lists.oasis-open.org>, <virtio-comment@lists.oasis-open.org>,
        <cohuck@redhat.com>, <harald.mommer@opensynergy.com>,
        <broonie@kernel.org>, <qiang4.zhang@linux.intel.com>,
        <quic_ztu@quicinc.com>
References: <20231201082143.14870-1-quic_haixcui@quicinc.com>
 <20231201082143.14870-3-quic_haixcui@quicinc.com>
 <20231201083753.uw7i2rwymak4etnj@vireshk-i7>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20231201083753.uw7i2rwymak4etnj@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GYFadedMEMr78qoqFoDTnRCSm9recujr
X-Proofpoint-ORIG-GUID: GYFadedMEMr78qoqFoDTnRCSm9recujr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-03_24,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=612 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040016
Subject: Re: [virtio-dev][PATCH V7 2/2] virtio-spi: add the device
 specification

Hi Viresh,

On 12/1/2023 4:37 PM, Viresh Kumar wrote:
> On 01-12-23, 16:21, Haixu Cui wrote:
>> The Virtio SPI (Serial Peripheral Interface) device is a virtual
>> SPI controller that allows the driver to operate and use the SPI
>> controller under the control of the device.
>>
>> This patch adds the specification for virtio-spi.
>>
>> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
>> ---
>>   device-types/spi/description.tex        | 280 ++++++++++++++++++++++++
>>   device-types/spi/device-conformance.tex |   7 +
>>   device-types/spi/driver-conformance.tex |   7 +
>>   3 files changed, 294 insertions(+)
>>   create mode 100644 device-types/spi/description.tex
>>   create mode 100644 device-types/spi/device-conformance.tex
>>   create mode 100644 device-types/spi/driver-conformance.tex
>>
>> diff --git a/device-types/spi/description.tex b/device-types/spi/description.tex
>> new file mode 100644
>> index 0000000..7c81df5
>> --- /dev/null
>> +++ b/device-types/spi/description.tex
>> @@ -0,0 +1,280 @@
>> +\section{SPI Controller Device}\label{sec:Device Types / SPI Controller Device}
>> +
>> +The Virtio SPI (Serial Peripheral Interface) device is a virtual SPI controller that
>> +allows the driver to operate and use the SPI controller under the control of the device,
> 
> I feel the terminology here is still a bit confusing:
> 
> "the SPI controller under the control of the device"
> 
> The Virtio SPI controller is "the device" and it is not under its own control.

Exactly. I will update the statement as follows:

The Virtio SPI (Serial Peripheral Interface) device is a virtual SPI 
controller that allows the driver to operate and use the SPI controller 
under the control of the host, either a physical SPI controller, or an 
emulated one.
> 
> As I suggested earlier, maybe this should be written as:
> 
> "the SPI controller under the control of the guest"
> 
>> +either a physical SPI controller, or an emulated one.
> 
> I just skimmed through the rest this time. Thanks for your effort.

Thank you so much for your supports and helpful comments. Really appreciate.

> 
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Best Regards
Haixu Cui

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

