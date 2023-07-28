Return-Path: <virtio-dev-return-13415-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA794EB64DD
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Jul 2023 06:53:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2B2DA1318CB
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Jul 2023 06:53:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 19C55986854
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Jul 2023 06:53:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0987C986803; Fri, 28 Jul 2023 06:53:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E602F986801;
	Fri, 28 Jul 2023 06:53:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <e2d093a3-c7c8-79f7-992a-e10fb06fc80d@quicinc.com>
Date: Fri, 28 Jul 2023 14:53:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Harald Mommer <harald.mommer@opensynergy.com>,
        <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
        <virtio-comment@lists.oasis-open.org>
CC: <quic_ztu@quicinc.com>,
        Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>
References: <20230417140353.870-1-quic_haixcui@quicinc.com>
 <20230417140353.870-3-quic_haixcui@quicinc.com>
 <98b247c1-b970-72ba-6888-f83144f08116@opensynergy.com>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <98b247c1-b970-72ba-6888-f83144f08116@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LTREIbod3uzE7WuQyWeWvLjOm-qCOjFN
X-Proofpoint-ORIG-GUID: LTREIbod3uzE7WuQyWeWvLjOm-qCOjFN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=984 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280061
Subject: Re: [virtio-dev][PATCH 2/2] virtio-spi: add the device specification

Hello Harald Mommer,
     I've searched but didn't found opensource virtio SPI Linux driver 
or any document/spec about this.

     We implement the virtio SPI prototype, based on the third-party 
non-opensource hypervisor.

Thanks & Best Regards
Haixu Cui

On 7/21/2023 9:50 PM, Harald Mommer wrote:
> Hello,
> 
> is there already some virtio SPI Linux driver published to the public to 
> have a chance to look at?
> 
> Same question for the device side. Is there a qemu device (or something 
> for a different virtualization environment like kvmtool) already 
> published to the public anywhere?
> 
> The spec made the impression that it's in an early stage so I expect 
> there is nothing yet but I may be wrong with my assumption.
> 
> On 17.04.23 16:03, Haixu Cui wrote:
>> virtio-spi is a virtual SPI master and it allows a guset to operate and
>> use the physical SPI master controlled by the host.
>> ---
>>   device-types/spi/description.tex        | 155 ++++++++++++++++++++++++
>>   device-types/spi/device-conformance.tex |   7 ++
>>   device-types/spi/driver-conformance.tex |   7 ++
>>   3 files changed, 169 insertions(+)
>>   create mode 100644 device-types/spi/description.tex
>>   create mode 100644 device-types/spi/device-conformance.tex
>>   create mode 100644 device-types/spi/driver-conformance.tex
> 
> Regards
> Harald Mommer
> 
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

