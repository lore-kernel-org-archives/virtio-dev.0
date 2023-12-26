Return-Path: <virtio-dev-return-14200-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E3AC3DA6E
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Dec 2023 03:12:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3A8E4A4007
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Dec 2023 03:12:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3202098640D
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Dec 2023 03:12:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 23EB1983D69; Tue, 26 Dec 2023 03:12:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E9D9986378;
	Tue, 26 Dec 2023 03:12:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <5e7f3850-9441-42b0-917e-cf25f8a82594@quicinc.com>
Date: Tue, 26 Dec 2023 11:11:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, <virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>, <harald.mommer@opensynergy.com>,
        <broonie@kernel.org>, <viresh.kumar@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20231212033317.22198-1-quic_haixcui@quicinc.com>
 <20231212033317.22198-3-quic_haixcui@quicinc.com> <877cl65sxx.fsf@redhat.com>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <877cl65sxx.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FkeEdgHyT400U-IzOcBWOQn8qWwnVgnb
X-Proofpoint-GUID: FkeEdgHyT400U-IzOcBWOQn8qWwnVgnb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 mlxlogscore=490 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312260023
Subject: Re: [virtio-dev][PATCH V9 2/2] virtio-spi: add the device
 specification



On 12/22/2023 8:21 PM, Cornelia Huck wrote:
> On Tue, Dec 12 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:
> 
>> The Virtio SPI (Serial Peripheral Interface) device is a virtual
>> SPI controller that allows the driver to operate and use the SPI
>> controller under the control of the host.
>>
>> This patch adds the specification for virtio-spi.
>>
>> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
>> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>   device-types/spi/description.tex        | 281 ++++++++++++++++++++++++
>>   device-types/spi/device-conformance.tex |   7 +
>>   device-types/spi/driver-conformance.tex |   7 +
>>   3 files changed, 295 insertions(+)
>>   create mode 100644 device-types/spi/description.tex
>>   create mode 100644 device-types/spi/device-conformance.tex
>>   create mode 100644 device-types/spi/driver-conformance.tex
> 
> Oh, and I just noticed that you also need to include
> {device,driver}-conformance.tex in conformance.tex.
> 

I will add the device and driver in conformance.tex in patch 2.

Thanks
Haixu Cui

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

