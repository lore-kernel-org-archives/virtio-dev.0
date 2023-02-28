Return-Path: <virtio-dev-return-11331-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E107C64EC7
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 08:10:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3C6282A82B
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 08:10:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 35E70986625
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 08:10:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2B52C986601; Tue, 28 Feb 2023 08:10:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 185179865FA;
	Tue, 28 Feb 2023 08:10:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VciHGiz_1677571839;
Message-ID: <0fca572e-6592-7d64-7d41-62c0220f22bd@linux.alibaba.com>
Date: Tue, 28 Feb 2023 16:10:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 Parav Pandit <parav@nvidia.com>, David Edmondson
 <david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230226093724.44717-1-hengqi@linux.alibaba.com>
 <CAJs=3_CGcYc1dPv2x+U-vy7smGBQ3cGWNzi_D-KzpMT2RdVzrg@mail.gmail.com>
 <1ba1c6ed-6a3f-21e6-dbb2-0f1a1ed9ca62@linux.alibaba.com>
 <CAJs=3_DND7WdoXc19XzOKDDKYNXFKdKRMr6j93p9z7=5EyGHGQ@mail.gmail.com>
 <20230227151420-mutt-send-email-mst@kernel.org>
 <46d5248b-1632-22b1-03b0-7ca64d536f04@linux.alibaba.com>
 <20230228024829-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230228024829-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH v9] virtio-net:
 support the virtqueue coalescing moderation
Message-ID: <20230228081038.lJLseOx_iXHUy0OBGT-hfvp9E_Me5Ll3XazwFeeJvCU@z>



在 2023/2/28 下午3:49, Michael S. Tsirkin 写道:
> On Tue, Feb 28, 2023 at 10:41:18AM +0800, Heng Qi wrote:
>>> The problem is the global qualifier. And it's not even global -
>>> there are two sets for rx and for tx and does not apply to cvq at all.
>>> How about "RX/TX coalescing parameters"?
>> As Parav suggested, we probably don't need to mention "global
>> values/coalescing parameters" since this values/parameters are the ones set
>> by CTRL_NOTF_COAL_RX/TX_SET.
>>
>> Just like this:
>> "
>> After disabling and re-enabling a virtuqueue, the device MUST revert to
>> coalescing parameters to the one configured using VIRTIO_NET_CTRL_NOTF_COAL.
>> "
>>
>> Thanks.
> VIRTIO_NET_CTRL_NOTF_COAL is not a thing. Let's wait for Alvaro's new
> patch to be merged though, see what teminology he comes up with and
> reuse.

Ok, are you referring to Alvaro's "virtio-net: Fix and update 
VIRTIO_NET_F_NOTF_COAL feature",
if so I see that his v7 version is stable and has been voted in 
https://github.com/oasis-tcs/ virtio-spec/issues/159 ,
this patch was made on top of his v7 version.

Thanks.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

