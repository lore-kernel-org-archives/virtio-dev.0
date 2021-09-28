Return-Path: <virtio-dev-return-8730-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 914F298645B
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Sep 2021 09:22:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <CACGkMEvSa6Q=BpMsOKR7Ax+tRGikm=hxGCb3rxDAFzOCN1OPhA@mail.gmail.com>
References: <20210927123153.20242-1-xuanzhuo@linux.alibaba.com>
 <20210927123153.20242-3-xuanzhuo@linux.alibaba.com>
 <87sfxqcbr4.fsf@redhat.com>
 <CACGkMEvSa6Q=BpMsOKR7Ax+tRGikm=hxGCb3rxDAFzOCN1OPhA@mail.gmail.com>
Date: Tue, 28 Sep 2021 11:22:03 +0200
Message-ID: <87fstp5a2s.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v3 2/2] virtio: pci support virtqueue reset
Content-Type: text/plain
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Sep 28 2021, Jason Wang <jasowang@redhat.com> wrote:

> On Mon, Sep 27, 2021 at 10:51 PM Cornelia Huck <cohuck@redhat.com> wrote:
>> For CCW, maybe we can add a payload to the existing RESET command if the
>> feature has been negotiated;
>
> I wonder if it's better for a new dedicated command. Consider device
> reset is different from virtqueue reset.

Yes, either can work. I'm trying to be a bit conservative with
allocating new commands, but if it is too confusing, we can use a new
one. The important thing is that I think this can be implemented for ccw
as well.

>
> Thanks
>
>> the queue can be re-enabled by the normal
>> READ_VQ_CONF/SET_VQ procedure. I have not yet thought that through.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

