Return-Path: <virtio-dev-return-14108-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210D9C4167B
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Dec 2023 02:24:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 650A12AC4B
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Dec 2023 02:24:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5FF6498640C
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Dec 2023 02:24:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 53FC498637E; Mon,  4 Dec 2023 02:24:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 416E8986376;
	Mon,  4 Dec 2023 02:24:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <9bf22a9a-1885-411e-951e-a22bf828da88@quicinc.com>
Date: Mon, 4 Dec 2023 10:24:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, <virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>, <harald.mommer@opensynergy.com>,
        <broonie@kernel.org>, <qiang4.zhang@linux.intel.com>,
        <viresh.kumar@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20231130092242.17303-1-quic_haixcui@quicinc.com>
 <20231130092242.17303-3-quic_haixcui@quicinc.com> <87r0k7lbd2.fsf@redhat.com>
 <b459c448-5e45-4cdd-bb06-06db040348bd@quicinc.com>
 <87leaekwyn.fsf@redhat.com>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <87leaekwyn.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MK8slAjVvG_1Bvo3SB7adhHIuMn-Wy3S
X-Proofpoint-ORIG-GUID: MK8slAjVvG_1Bvo3SB7adhHIuMn-Wy3S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-03_24,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=644 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040016
Subject: Re: [virtio-dev] [PATCH V6 2/2] virtio-spi: add the device
 specification

Hi Huck,

On 12/1/2023 7:01 PM, Cornelia Huck wrote:
> On Fri, Dec 01 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:
> 
>>>> +Note: chipselect is an electrical signal controlled by the SPI controller, used to select the
>>>> +SPI slaves connected to the controller.
>>>
>>> I wonder whether another term is now more commonly used... the Wikipedia
>>> article uses main/sub, is there a term that is usually used together
>>> with "controller"?
>>
>> In Wikipedia,
>>
>> "Historically, this arrangement has been called master/slave. But to
>> avoid referencing slavery, alternative names discussed in § Alternative
>> namings have been used."
>>
>> I am not quite sure if main/sub is widely used, but in latest Linux,
>> still use master/slave but master is gradually replaced by "controller".
>>
>> So I think "controller" here does make sense. What is your suggestion?
> 
> "controller" is fine, I'm just wondering if "slave" has started to be
> replaced with something else as well... if it hasn't, we probably need
> to stick with it to avoid confusing readers.
> 

slave is still being used, but it's better to be used along with "master".

Here I prefer using "SPI peripherals" instead of "SPI slaves". Looking 
forward to your advice. Thank you so much.

Best Regards
Haixu Cui

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

