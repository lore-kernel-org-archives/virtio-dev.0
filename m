Return-Path: <virtio-dev-return-14124-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B04C4167B
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Dec 2023 03:59:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2A13E216AE
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Dec 2023 03:59:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1E2EE9868F3
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Dec 2023 03:59:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0F195986689; Wed,  6 Dec 2023 03:59:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF00E986688;
	Wed,  6 Dec 2023 03:58:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <efb59952-9ef5-4c9b-9667-19633646b255@quicinc.com>
Date: Wed, 6 Dec 2023 11:58:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Harald Mommer <harald.mommer@opensynergy.com>,
        <virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>, <cohuck@redhat.com>,
        <broonie@kernel.org>, <qiang4.zhang@linux.intel.com>,
        <viresh.kumar@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20231205082401.18111-1-quic_haixcui@quicinc.com>
 <20231205082401.18111-2-quic_haixcui@quicinc.com>
 <725bdcfe-9678-448d-8f8e-dc7fe1f19289@opensynergy.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <725bdcfe-9678-448d-8f8e-dc7fe1f19289@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JZ5nMyRxHejUsZe5QU__SjHA9nf0q8Bt
X-Proofpoint-ORIG-GUID: JZ5nMyRxHejUsZe5QU__SjHA9nf0q8Bt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060031
Subject: Re: [virtio-dev][PATCH V8 1/2] content: Rename SPI master to SPI
 controller

Hello Harald,

On 12/5/2023 11:14 PM, Harald Mommer wrote:
> Hello,
> 
> On 05.12.23 09:24, Haixu Cui wrote:
>> SPI master is an outdated term and should use SPI controller.
>>
>> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
>> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>   content.tex | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/content.tex b/content.tex
>> index 0a62dce..1c608eb 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -737,7 +737,7 @@ \chapter{Device Types}\label{sec:Device Types}
>>   \hline
>>   44         &   ISM device \\
>>   \hline
>> -45         &   SPI master \\
>> +45         &   SPI controller \\
>>   \hline
>>   \end{tabular}
> 
> Please add somewhere behind
> 
> \input{device-types/pmem/description.tex}
> 
> the line
> 
> \input{device-types/spi/description.tex}
> 
> so that I get my PDF generated without having to add this line all the 
> time manually.

Sure I will.

> 
> Regards
> Harald
>

Thanks & Regards
Haixu Cui

> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

