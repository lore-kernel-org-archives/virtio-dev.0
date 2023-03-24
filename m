Return-Path: <virtio-dev-return-11771-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319A2C6FD1C
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 08:14:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 89B032B01B
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 08:14:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6FFBF98646D
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 08:14:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 58F8798642D; Fri, 24 Mar 2023 08:14:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 44C56986399;
	Fri, 24 Mar 2023 08:14:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <9cd01fb9-f7a4-7d5a-bfef-6d1eb810e2d2@quicinc.com>
Date: Fri, 24 Mar 2023 16:14:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To: Cornelia Huck <cohuck@redhat.com>, <virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>
CC: <quic_ztu@quicinc.com>
References: <20230227082329.31337-1-quic_haixcui@quicinc.com>
 <87h6umta2t.fsf@redhat.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <87h6umta2t.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DxFJdV1ryWeEZ1lNGzvmlCC4fXvM-MIp
X-Proofpoint-ORIG-GUID: DxFJdV1ryWeEZ1lNGzvmlCC4fXvM-MIp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_04,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 suspectscore=0 mlxlogscore=718 spamscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240068
Subject: Re: [virtio-dev] [PATCH] virtio-spi: add the device specification

Hi Cornelia Huck,
     Thank you for your comments.
     SPI here means 'Serial Peripheral Interface'. And according to your 
suggestion, I submit again to remove the introduction of Virtio ID.

Best Regards
Haixu Cui


On 3/15/2023 9:31 PM, Cornelia Huck wrote:
> On Mon, Feb 27 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:
> 
>> virtio-spi is a virtual SPI master and it allows a guset to operate and
>> use the physical SPI master controlled by the host.
>>
>> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
>> ---
>>   content.tex                             |   2 +
>>   device-types/spi/description.tex        | 153 ++++++++++++++++++++++++
>>   device-types/spi/device-conformance.tex |   7 ++
>>   device-types/spi/driver-conformance.tex |   7 ++
>>   4 files changed, 169 insertions(+)
>>   create mode 100644 device-types/spi/description.tex
>>   create mode 100644 device-types/spi/device-conformance.tex
>>   create mode 100644 device-types/spi/driver-conformance.tex
>>
>> diff --git a/content.tex b/content.tex
>> index 0c7cdf8..86bf709 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -2994,6 +2994,8 @@ \chapter{Device Types}\label{sec:Device Types}
>>   \hline
>>   44         &   ISM device \\
>>   \hline
>> +45         &   SPI Master \\
> 
> What is 'SPI'? 'Serial Peripheral Interface', I guess?
> 
> Introduction of the ID should be split out into a separate patch; if
> people agree that this is a useful thing to add, please open a github
> issue and request a vote.
> 
>> +\hline
>>   \end{tabular}
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

