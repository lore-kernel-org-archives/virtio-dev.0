Return-Path: <mst@redhat.com>
Date: Thu, 11 Aug 2022 07:15:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH 1/4] content: Introduce driver/device
 auxiliary notifications
Message-ID: <20220811071300-mutt-send-email-mst@kernel.org>
References: <20220330152105.3770439-1-usama.arif@bytedance.com>
 <20220330152105.3770439-2-usama.arif@bytedance.com>
 <20220809160711-mutt-send-email-mst@kernel.org>
 <87r11octk4.fsf@redhat.com>
 <20220810194108.78059919.pasic@linux.ibm.com>
 <20220810152105-mutt-send-email-mst@kernel.org>
 <87ilmzcffd.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87ilmzcffd.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Usama Arif <usama.arif@bytedance.com>, virtio-dev@lists.oasis-open.org, stefanha@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Aug 11, 2022 at 11:12:06AM +0200, Cornelia Huck wrote:
> >> OTOH when reading the spec, it my strike one as strange, that for example
> >> CCW does not mention aux notifications at all. One idea: maybe we could
> >> add a note, or a subsection, or something, which states the list of
> >> general optional virtio facilities or features not supported by the given
> >> transport on the spec level for a given incarnation of the spec.
> >
> > Yes I think each transport should list features it does not
> > support, and a feature specific to some transports must
> > also require that other transports disable it and
> > that drivers do not ack it.
> > Otherwise it's too easy for devices to offer the feature bit
> > by mistake.
> 
> Do we need to add a requirement for every transport-specific feature, or
> would it be sufficient to add a statement like "if a feature requires a
> transport-specific implementation, a device using that transport MUST
> NOT offer that feature"?


I'd prefer to list the features explicitly.

In particular is kind of forces whoever is proposing
the feature into at least be aware that other transports
exist and that the proposal is incomplete.


> >
> >> I think making the people not motivated to do the design and write the
> >> spec for all the platforms add to that list is a reasonable middle
> >> ground. It would also make the differences very clear, and the same goes
> >> for the intention (i.e. not omitted by mistake).
> 
> Hm. On the one hand, I like that it would add a laundry list for
> transports regarding features that might be implemented. On the other
> hand, I think the main problem is not enough people with enough
> understanding and bandwidth to add new features everywhere... but I
> suppose that needs to be fixed in a different place anyway.

