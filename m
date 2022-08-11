Return-Path: <virtio-dev-return-9766-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D23BB986411
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Aug 2022 09:12:11 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220810152105-mutt-send-email-mst@kernel.org>
References: <20220330152105.3770439-1-usama.arif@bytedance.com>
 <20220330152105.3770439-2-usama.arif@bytedance.com>
 <20220809160711-mutt-send-email-mst@kernel.org>
 <87r11octk4.fsf@redhat.com> <20220810194108.78059919.pasic@linux.ibm.com>
 <20220810152105-mutt-send-email-mst@kernel.org>
Date: Thu, 11 Aug 2022 11:12:06 +0200
Message-ID: <87ilmzcffd.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH 1/4] content: Introduce driver/device
 auxiliary notifications
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Usama Arif <usama.arif@bytedance.com>, virtio-dev@lists.oasis-open.org, stefanha@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Aug 10 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Aug 10, 2022 at 07:41:08PM +0200, Halil Pasic wrote:
>> On Wed, 10 Aug 2022 11:54:35 +0200
>> Cornelia Huck <cohuck@redhat.com> wrote:
>> > This highlights another problem, however: When we introduce new features
>> > that require a transport-specific implementation, we often end up with a
>> > PCI implementation, but sometimes MMIO and more often ccw are left
>> > behind -- which is understandable, as PCI is what most people use, and
>> > ccw is something only a very few people are familiar with. This sadly
>> > means that we have a backlog of features supported in PCI, but not in
>> > ccw... requiring implementations for ccw would put an undue burden on
>> > contributors, as most of them are unlikely to write anything for a
>> > mainframe, ever. On the flip side, I do not have enough bandwith to deal
>> > with all of this.
>> 
>> I'm completely with you in a sense that I see the same problem. I think
>> we have to get these resolved on a case by case basis. In my opinion at
>> least in theory it would make a big difference, whether the new feature
>> obligatory or not. But since VIRTIO is big on compatibility, and also
>> cares about the initial investment required, in practice, I think, we
>> are mostly good with the transports delivering features on their own
>> schedule. What I mean here is: it is kind of difficult to make a new
>> facility (like shm, or aux notifications) mandatory, because stuff
>> that conform to a previous incarnation of the spec would become
>> non-conform.

I don't think there's a big case for making new things mandatory;
everything should be guarded by a feature bit or similar.

>> 
>> And the people who care about the particular transport, and the users
>> of the transport (indirectly also platforms) should make up their own
>> mind with regards to whether and when to invest into the new facilities
>> and the new tech and opportunities associated with those.

PCI will probably satisfy the needs of the vast majority of users, and
MMIO is not too alien to just change at the same time. ccw is the big
problem. Is IBM still spending resources on virtio-ccw? [My own
involvement with s390x has dwindled a lot, so it would be great to see
some of it picked up by others. Certainly not trying to pin everything
on Halil, though.]

>> 
>> OTOH when reading the spec, it my strike one as strange, that for example
>> CCW does not mention aux notifications at all. One idea: maybe we could
>> add a note, or a subsection, or something, which states the list of
>> general optional virtio facilities or features not supported by the given
>> transport on the spec level for a given incarnation of the spec.
>
> Yes I think each transport should list features it does not
> support, and a feature specific to some transports must
> also require that other transports disable it and
> that drivers do not ack it.
> Otherwise it's too easy for devices to offer the feature bit
> by mistake.

Do we need to add a requirement for every transport-specific feature, or
would it be sufficient to add a statement like "if a feature requires a
transport-specific implementation, a device using that transport MUST
NOT offer that feature"?

>
>> I think making the people not motivated to do the design and write the
>> spec for all the platforms add to that list is a reasonable middle
>> ground. It would also make the differences very clear, and the same goes
>> for the intention (i.e. not omitted by mistake).

Hm. On the one hand, I like that it would add a laundry list for
transports regarding features that might be implemented. On the other
hand, I think the main problem is not enough people with enough
understanding and bandwidth to add new features everywhere... but I
suppose that needs to be fixed in a different place anyway.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

