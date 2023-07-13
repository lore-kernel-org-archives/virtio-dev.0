Return-Path: <virtio-dev-return-13369-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFBDC0015E
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 06:40:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AF5F071C8C
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 06:40:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D12B9867C2
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 06:40:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8F69E983FE6; Thu, 13 Jul 2023 06:40:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 754299867C1;
	Thu, 13 Jul 2023 06:40:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VnG1DE7_1689230413;
Message-ID: <bb05b983-6db8-ac5a-032f-668b4ae47bbf@linux.alibaba.com>
Date: Thu, 13 Jul 2023 14:40:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230703152711.106008-1-hengqi@linux.alibaba.com>
 <87pm4xjp4t.fsf@redhat.com> <20230712082508-mutt-send-email-mst@kernel.org>
 <87jzv5jo82.fsf@redhat.com>
 <e0e2b21d-a7f9-fbf1-7d93-d142c7a7618a@linux.alibaba.com>
 <87h6q9jm85.fsf@redhat.com>
 <b1b03bfa-45ac-42b8-86d9-aaf47c4704e3@linux.alibaba.com>
 <87edldjgri.fsf@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <87edldjgri.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH
 v21] virtio-net: support inner header hash



在 2023/7/12 下午11:23, Cornelia Huck 写道:
> On Wed, Jul 12 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:
>
>> 在 2023/7/12 下午9:25, Cornelia Huck 写道:
>>> ...while the changes above give me a fine pdf, the html generated is
>>> broken. The problem seems to originate in the normative references that
>>> are added in introduction.tex, but I don't see where it goes astray.
>>>
>>> [401] [402] [403] [404] (./virtio-v1.2-cs01.aux
>>> ! Missing \endcsname inserted.
>>> <to be read again>
>>>                      \unhbox
>>> l.49 ...ction}Normative References}}{section.1}{}}
>>>                                                     
>>> ?
>>> ! Emergency stop.
>>> <to be read again>
>>>                      \unhbox
>>> l.49 ...ction}Normative References}}{section.1}{}}
>>>
>>> (makehtml.sh on master seems to work ok, so it's something in this
>>> patch...)
>>>
>>> Does anyone else manage to spot the problem?
>> The problem is that underline cannot be added directly in \textbf, we
>> need a little modification:
>>
>> \textbf{[GRE_rfc2784]} --> \textbf{[GRE\_rfc2784]}
>> \textbf{[GRE_rfc2890]} --> \textbf{[GRE\_rfc2890]}
>> \textbf{[GRE_rfc7676]} --> \textbf{[GRE\_rfc7676]}
>>
>> After this modification, I can successfully compile pdf on overleaf,
>> please try this.
> I'm afraid that's not the problem (I had tried this and similar changes
> without success); the pdf generation is already fine, but html still
> fails with this change (or similar).

*./makehtml.sh* does not allow '_' in \label (but allows '-'), after I 
remove '_' in introduction.tex then makehtml.sh
can succeed. The patch submitted by Parav has removed the '_' and 
replaced it with spaces, which also works.

Thanks.

>
> [Trying on a standard Fedora 37 with a full texlive install...]


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

