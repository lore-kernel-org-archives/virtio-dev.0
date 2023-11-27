Return-Path: <virtio-dev-return-14068-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185E7C4167B
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Nov 2023 12:20:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6E123330A5
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Nov 2023 12:20:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A60C9863BE
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Nov 2023 12:20:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5B6FA9863A1; Mon, 27 Nov 2023 12:20:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A940986394;
	Mon, 27 Nov 2023 12:20:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <001fcdf7-c221-4057-a2cf-200035b95816@quicinc.com>
Date: Mon, 27 Nov 2023 20:20:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mark Brown <broonie@kernel.org>
CC: <virtio-dev@lists.oasis-open.org>, <virtio-comment@lists.oasis-open.org>,
        <cohuck@redhat.com>, <harald.mommer@opensynergy.com>,
        <qiang4.zhang@linux.intel.com>, <quic_ztu@quicinc.com>
References: <20231124072015.12655-1-quic_haixcui@quicinc.com>
 <ZWCbm4pDET31Rn7z@finisterre.sirena.org.uk>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <ZWCbm4pDET31Rn7z@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LNuKq_qlVaQru1BR5VgpI-6rhs_747aK
X-Proofpoint-GUID: LNuKq_qlVaQru1BR5VgpI-6rhs_747aK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_09,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxlogscore=519 mlxscore=0
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270084
Subject: [virtio-dev] Re: [PATCH] [PATCH v5] virtio-spi: add the device specification

Hi Mark,
     Thank you, really appreciate.

Best Regards
Haixu Cui

On 11/24/2023 8:48 PM, Mark Brown wrote:
> On Fri, Nov 24, 2023 at 03:20:15PM +0800, Haixu Cui wrote:
>> virtio-spi is a virtual SPI (Serial Peripheral Interface) controller and it allows
>> a guest to operate and use the host SPI controller.
>>
>> This patch adds the specification for virtio-spi.
> 
> This looks fine from a SPI point of view, I don't really have any idea
> about what makes sense or is idomatic at the virtio level so can't
> really review there:
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

