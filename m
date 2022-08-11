Return-Path: <pasic@linux.ibm.com>
Date: Thu, 11 Aug 2022 16:41:49 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-dev] Re: [PATCH 1/4] content: Introduce driver/device
 auxiliary notifications
Message-ID: <20220811164149.2e6ed3a7.pasic@linux.ibm.com>
In-Reply-To: <87ilmzcffd.fsf@redhat.com>
References: <20220330152105.3770439-1-usama.arif@bytedance.com>
	<20220330152105.3770439-2-usama.arif@bytedance.com>
	<20220809160711-mutt-send-email-mst@kernel.org>
	<87r11octk4.fsf@redhat.com>
	<20220810194108.78059919.pasic@linux.ibm.com>
	<20220810152105-mutt-send-email-mst@kernel.org>
	<87ilmzcffd.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Usama Arif <usama.arif@bytedance.com>, virtio-dev@lists.oasis-open.org, stefanha@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 11 Aug 2022 11:12:06 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> >  
> >> I think making the people not motivated to do the design and write the
> >> spec for all the platforms add to that list is a reasonable middle
> >> ground. It would also make the differences very clear, and the same goes
> >> for the intention (i.e. not omitted by mistake).  
> 
> Hm. On the one hand, I like that it would add a laundry list for
> transports regarding features that might be implemented. 

I believe, all three of us are in agreement on this one. I could hack up
a spec-patch for ccw at some point in time which rectifies things for
the features that are already in the spec.

> In the other
> hand, I think the main problem is not enough people with enough
> understanding and bandwidth to add new features everywhere... but I
> suppose that needs to be fixed in a different place anyway.

I kind of agree, especially with the part that this is not the right
place to fix that problem, if it is a problem. Actually I see this
rather as a strength of virtio: a large amount of freedom in deciding
how much and where to invest. I would rather not specify stuff without
having some sort of a reference implementation, so the ability to
delay specifying how some optional features are to work with virtio-ccw
is very welcome form my perspective.

Regards,
Halil

