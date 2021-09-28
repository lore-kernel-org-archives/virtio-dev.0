Return-Path: <virtio-dev-return-8731-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D6B7498645B
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Sep 2021 09:26:32 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <1632811690.232091-1-xuanzhuo@linux.alibaba.com>
References: <1632811690.232091-1-xuanzhuo@linux.alibaba.com>
Date: Tue, 28 Sep 2021 11:26:27 +0200
Message-ID: <87czot59vg.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v3 2/2] virtio: pci support virtqueue reset
Content-Type: text/plain
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Sep 28 2021, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> On Mon, 27 Sep 2021 16:51:43 +0200, Cornelia Huck <cohuck@redhat.com> wrote:
>> MMIO can probably use a similar mechanism.
>>
>> For CCW, maybe we can add a payload to the existing RESET command if the
>> feature has been negotiated; the queue can be re-enabled by the normal
>> READ_VQ_CONF/SET_VQ procedure. I have not yet thought that through.
>
> Regarding CCW, can I consider adding this part later? This time I want to
> complete PCI and MMIO support for queue reset first.

Sure, I do not really expect people to come up with procedures for ccw;
I think it can be made to work.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

