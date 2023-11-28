Return-Path: <virtio-dev-return-14072-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24A9C4167B
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Nov 2023 12:23:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 48D0A2AEE3
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Nov 2023 12:23:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B0C398651F
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Nov 2023 12:23:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2E1ED98650B; Tue, 28 Nov 2023 12:23:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A2799864D2;
	Tue, 28 Nov 2023 12:23:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <15831eb4-d5cd-45dd-91a9-7e8e13d275a4@quicinc.com>
Date: Tue, 28 Nov 2023 20:23:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cornelia Huck <cohuck@redhat.com>, <virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>, <harald.mommer@opensynergy.com>,
        <broonie@kernel.org>, <qiang4.zhang@linux.intel.com>
CC: <quic_ztu@quicinc.com>
References: <20231124072015.12655-1-quic_haixcui@quicinc.com>
 <87ttpbxiga.fsf@redhat.com>
 <e293b937-42ff-43ba-80c0-bc4683f48db7@quicinc.com>
 <87il5nxof1.fsf@redhat.com> <87fs0rxo41.fsf@redhat.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <87fs0rxo41.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FaLesuTlauDEA_P7knfOszuQpzlOK2-p
X-Proofpoint-ORIG-GUID: FaLesuTlauDEA_P7knfOszuQpzlOK2-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_12,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280098
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH] [PATCH v5] virtio-spi: add the
 device specification



On 11/27/2023 10:33 PM, Cornelia Huck wrote:
> On Mon, Nov 27 2023, Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Mon, Nov 27 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:
>>
>>> On 11/24/2023 11:46 PM, Cornelia Huck wrote:
>>>> On Fri, Nov 24 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:
>>>>> +The \field{chip_select_max_number} is the maximum number of chipselect the host SPI controller supports.
>>>>
>>>> "chipselect" is probably a known term for people familiar with SPI -- is
>>>> there any definition of those terms that the spec can point to?
>>>
>>> Just as Mark said, there is no formal spec for SPI, so no standard spec
>>> for such terms referring to. The same for CPHA/CPOL/LSB/MSB, please see
>>> below.
>>
>> If we have nothing to point to, it is probably best to simply
>> expand/explain the terms on their first usage.
>>
>>>> Can we point to some documentation that explains CPHA and CPOL?
>>>
>>> Here. No standard SPI spec to point to. CPOL/CPHA have definitions in
>>> wikipedia(Clock polarity and phase chapter):
>>>
>>> https://en.wikipedia.org/wiki/Serial_Peripheral_Interface
>>>
>>> How about copying some concise information from wikipedia as Note? Or is
>>> referring to such webpage acceptable in this spec.
>>
>> Not sure if we can do an outright copy (licence compatibility), but
>> paraphrasing should be fine. (I'd rather not directly reference the
>> site, because the content is not guaranteed to be stable, but we could
>> maybe add it as "further reading".)
> 
> Looking again, the kernel doc referenced by Mark
> (https://www.kernel.org/doc/html/v6.6/driver-api/spi.html) might also be
> a good candidate, especially as we can refer to a specific version.
> 
This Linux doc is a good Normative References, but it doesn't have 
definitions of the terms, like chipselect, CPOA, LSB...

I will add some concise descriptions on their first usage.

Best Regards
Thanks

Haixu Cui

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

