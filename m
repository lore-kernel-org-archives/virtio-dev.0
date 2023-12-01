Return-Path: <virtio-dev-return-14101-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44348C4167B
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Dec 2023 05:50:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6D6D026A45
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Dec 2023 05:50:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDDCA986939
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Dec 2023 05:50:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4E4F498669D; Fri,  1 Dec 2023 05:50:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3744D98669A;
	Fri,  1 Dec 2023 05:49:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <54b86c0b-753c-49ad-8ca3-6bb9d2f49be3@quicinc.com>
Date: Fri, 1 Dec 2023 13:49:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <virtio-dev@lists.oasis-open.org>, <virtio-comment@lists.oasis-open.org>,
        <cohuck@redhat.com>, <harald.mommer@opensynergy.com>,
        <broonie@kernel.org>, <qiang4.zhang@linux.intel.com>,
        <quic_ztu@quicinc.com>
References: <20231130092242.17303-1-quic_haixcui@quicinc.com>
 <20231130092242.17303-3-quic_haixcui@quicinc.com>
 <20231130111900.ix3cfsxlns2blp4r@vireshk-i7>
 <b26382c1-6601-44b8-8376-3f96d605f2d5@quicinc.com>
 <20231201043203.7ozpnk2k3dci4pq4@vireshk-i7>
 <bd50a1e1-75ab-41c3-9fdd-9cfbeb13034e@quicinc.com>
 <20231201054403.kpykp6g7kggxsgyo@vireshk-i7>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20231201054403.kpykp6g7kggxsgyo@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cEd8zh-S_12zIvdaAHsKVFpQq4AAuLEs
X-Proofpoint-ORIG-GUID: cEd8zh-S_12zIvdaAHsKVFpQq4AAuLEs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_03,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=787 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312010033
Subject: Re: [virtio-dev] [PATCH V6 2/2] virtio-spi: add the device
 specification

Hi Viresh,

On 12/1/2023 1:44 PM, Viresh Kumar wrote:
> On 01-12-23, 13:35, Haixu Cui wrote:
>> Hi Viresh,
>>
>>      SPI transfer modes here may cause misunderstanding, in Wikipedia, SPI
>> mode is the combinations of clock polarity and clock phases:
>>
>>
>> https://en.wikipedia.org/w/index.php?title=Serial_Peripheral_Interface&action=edit&section=4
> 
> The word 'mode' is indeed confusing. It is used for combinations of PHA/POL,
> half/full duplex, n-bit transfers, etc..

Yes, it is. In this spec, for half/full duplex, I use "transfer type", 
and for line number, just use "n-bit transfer", to avoid ambiguity.
> 
>>      What about updating as: "Note: The commonly used SPI n-bit transfer
>> options are:"
> 
> That's fine too.
> 
OK, thank you.

Best Regards
Haixu Cui

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

