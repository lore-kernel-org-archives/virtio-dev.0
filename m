Return-Path: <virtio-dev-return-10583-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA4A59865B7
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Jan 2023 16:07:16 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230112164132.09d292e5.pasic@linux.ibm.com>
References: <20221223081354.15026-1-xuanzhuo@linux.alibaba.com>
 <20221223081354.15026-2-xuanzhuo@linux.alibaba.com>
 <20230110233401.131cc97a.pasic@linux.ibm.com>
 <1673435333.1297436-1-xuanzhuo@linux.alibaba.com>
 <20230111161128.48e6d7e0.pasic@linux.ibm.com>
 <CACGkMEuT5L2DH1ga+HOJb0DHdF04VmvC3viEoRPhraLxc7RCjg@mail.gmail.com>
 <20230112014722-mutt-send-email-mst@kernel.org>
 <87zgaocffm.fsf@redhat.com>
 <1673524110.7417235-2-xuanzhuo@linux.alibaba.com>
 <87r0vzddul.fsf@redhat.com> <20230112164132.09d292e5.pasic@linux.ibm.com>
Date: Thu, 12 Jan 2023 17:07:09 +0100
Message-ID: <87lem7d9ea.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v2 1/1] virtio-ism: introduce new device
 virtio-ism
Content-Type: text/plain
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, Jan Kiszka <jan.kiszka@siemens.com>, wintera@linux.ibm.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com, raspl@linux.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 12 2023, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 12 Jan 2023 15:30:58 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> >>
>> >> I like that: we don't want to talk about hosts/VMMs/etc. as we
>> >> fundamentally deal with devices and drivers, but sharing between guests
>> >> is of course the obvious use case.
>> >>
>> >> I'm just wondering how best to express the uniqueness scope, is it per
>> >> (ISM) device?  
>> >
>> > No, each vm has at least one separate device. The devices in a host form
>> > an uniqueness scope.  
>> 
>> Should we call it a 'group', then? A host would be an example of such a
>> group.
>
> How about 'communication domain'? Devices within a single communication
> domain may be able to speak to each other via SMC and may not have the
> same device_id. Two devices from different communication domains can't
> communicate via ISM, but may have the same device_id.
>
> I don't like group because it is very generic, and may sound like
> the grouping can be done arbitrarily. E.g. with a shared memory based
> implementation akin to the PoC putting devices on different hosts into
> the same 'group' should be illegal.

Yes, 'communication domain' sounds better.

>
> On the other hand there is also the following question. If we move away
> form the one ID per host model ("The device MUST ensure that the gid on
> the same entity i same and different from the gid on other entity.") then
> we could also allow having more than one communication domains on a
> single host (to limit what entities can use ISM to communicate).

Makes sense, I guess. But I haven't looked too much into the details of
ism yet.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

