Return-Path: <virtio-dev-return-13307-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0661EB64DA
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 09:18:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 251292ACB9
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 09:18:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1EBDE986816
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 09:18:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 120FF986800; Fri,  7 Jul 2023 09:18:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F23349867EB;
	Fri,  7 Jul 2023 09:18:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <40e540f0-b07e-63af-d639-bcd71e4b23a1@quicinc.com>
Date: Fri, 7 Jul 2023 17:17:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
CC: <virtio-dev@lists.oasis-open.org>, <quic_ztu@quicinc.com>,
        <virtio-comment@lists.oasis-open.org>, <jrreinhart@google.com>
References: <20230417140353.870-1-quic_haixcui@quicinc.com>
 <20230417140353.870-2-quic_haixcui@quicinc.com>
 <20230630105606-mutt-send-email-mst@kernel.org>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20230630105606-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R8v3gYWB-cWQMSWC66sUhDsXmDqpkEPQ
X-Proofpoint-ORIG-GUID: R8v3gYWB-cWQMSWC66sUhDsXmDqpkEPQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307070085
Subject: Re: [virtio-dev][PATCH 1/2] virtio-spi: define the DEVICE ID for
 virtio SPI master

Hi Michael S. Tsirkin, Cornelia Huck,
     I have created an issue 
https://github.com/oasis-tcs/virtio-spec/issues/174 to request Device ID 
45 for SPI master. Please help to deal with it, thank you very much.

Best Regards
Haixu Cui

On 6/30/2023 10:57 PM, Michael S. Tsirkin wrote:
> On Mon, Apr 17, 2023 at 10:03:52PM +0800, Haixu Cui wrote:
>> Define the DEVICE ID of virtio SPI master device as 45.
> 
> It does not looks like patch 2 will make it in time for 1.3
> but should we vote on reserving device id maybe?
> If yes pls create a github issue and request vote on list.
> 
>> ---
>>   content.tex | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/content.tex b/content.tex
>> index cff548a..29f2859 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -682,6 +682,8 @@ \chapter{Device Types}\label{sec:Device Types}
>>   \hline
>>   44         &   ISM device \\
>>   \hline
>> +45         &   SPI master \\
>> +\hline
>>   \end{tabular}
>>   
>>   Some of the devices above are unspecified by this document,
>> -- 
>> 2.17.1
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

