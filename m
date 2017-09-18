Return-Path: virtio-dev-return-2548-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8BAEA5819241
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Sep 2017 06:08:28 -0700 (PDT)
References: <1505092362-10544-1-git-send-email-longpeng2@huawei.com>
 <1505092362-10544-2-git-send-email-longpeng2@huawei.com>
 <67d5549e-84de-ee85-00a7-37edc52234c4@linux.vnet.ibm.com>
 <33183CC9F5247A488A2544077AF19020DA3D9A7B@DGGEMA505-MBX.china.huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 18 Sep 2017 15:08:16 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA3D9A7B@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <73b9f2a8-6746-593b-4277-3ea757476130@linux.vnet.ibm.com>
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH REPOST v19 1/2] virtio-crypto: Add virtio
 crypto device specification
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng <longpeng2@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "agraf@suse.de" <agraf@suse.de>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 09/18/2017 02:13 PM, Gonglei (Arei) wrote:
>> Destroy does not need to specify queue_id. That means session_id's aren't
>> queue scoped from namespace perspective. The question remains what is
>> queue_id good for, and whether a session type op request should be
>> rejected if the the session id originates from a session creation
>> request specifying a different dataqueue (not the dataqueue containing
>> the given request)?
>>
> My original idea about the queue_id is using the queue_id to specify which
> datequeue of the following data requests will be used. But after deep thinking,
> I find that the queue_id is superfluous, and the current code in QEMU also
> don't use the queue_id value as well. That's because the we can use session_id
> to find the pervious session information and get the current dataqueue id
> from the used virtqueue .
> 
> So maybe we should drop the queue_id this time.
> 
> 

Sounds reasonable to me. We can make it reserved and ignored in
the specification. Linux uses it, but it's always set to 0 as we only
support one data-queue (if I'm not wrong). So reserved and must be zero
is an option too.

Halil


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

