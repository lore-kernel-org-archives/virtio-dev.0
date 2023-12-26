Return-Path: <virtio-dev-return-14199-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AC6C3DA6E
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Dec 2023 03:05:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D8F828D303
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Dec 2023 03:05:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CCB049863B3
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Dec 2023 03:05:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BE7FE986295; Tue, 26 Dec 2023 03:05:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AB5A9986378;
	Tue, 26 Dec 2023 03:05:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <30ff9b4e-3306-4768-888a-0663f42b0715@quicinc.com>
Date: Tue, 26 Dec 2023 11:05:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, <virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>, <harald.mommer@opensynergy.com>,
        <broonie@kernel.org>, <viresh.kumar@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20231212033317.22198-1-quic_haixcui@quicinc.com>
 <20231212033317.22198-3-quic_haixcui@quicinc.com> <87wmtbg4ad.fsf@redhat.com>
 <e076f6b7-595e-4910-96c9-96366faadfe8@quicinc.com>
 <87cyv0eyhy.fsf@redhat.com>
 <86d97639-eb01-4db7-88ec-0adccb45abec@quicinc.com>
 <87a5q3g9t4.fsf@redhat.com>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <87a5q3g9t4.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UZHXRpKPTEu__x5quIw4gYSKlw5_6pLg
X-Proofpoint-ORIG-GUID: UZHXRpKPTEu__x5quIw4gYSKlw5_6pLg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=862 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312260021
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev][PATCH V9 2/2] virtio-spi: add
 the device specification



On 12/21/2023 5:54 PM, Cornelia Huck wrote:
> On Thu, Dec 21 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:
> 
>> Hi Cornelia,
>>
>> On 12/21/2023 4:44 PM, Cornelia Huck wrote:
>>> On Thu, Dec 21 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:
>>>>> Please move inclusion of this new file into content.tex here, instead of
>>>>> including a not-yet-existing file in the previous patch.
>>>>>
>>>>> (...)
>>>>
>>>>
>>>> Sorry, I don't quite understand here. Maybe I should not add the
>>>> following line in content.tex, is that so?
>>>>
>>>> \input{device-types/spi/description.tex}
>>>
>>> No, please add this line; but do so in this patch instead of the
>>> previous one that only changes the wording.
>>
>> I am not clear where to put this line? In the commit message or in the
>> main text, e.g. at the start of the description.tex? As follows:
>>
>> diff --git a/device-types/spi/description.tex
>> b/device-types/spi/description.tex
>> new file mode 100644
>> index 0000000..b76258c
>> --- /dev/null
>> +++ b/device-types/spi/description.tex
>> @@ -0,0 +1,281 @@
>> +\input{device-types/spi/description.tex}
>> +\section{SPI Controller Device}\label{sec:Device Types / SPI Controller
>> Device}
>> +
>> ...
> 
> Ah no, the inclusion is of course in the right place where you put it in
> context.tex; the *patch hunk* should be moved from patch 1 to patch 2,
> that's all. Hope that's more clear now :)
> 
Hello Cornelia,

Oh I think I get it. The patch 1 should be split into two. Changing the 
wording is still in patch 1 and the line 
"\input{device-types/spi/description.tex}" should be move to patch 2.

Thank you very much for your detailed explanations, I will do so in next 
patch.

Best Regards
Haixu Cui

> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

