Return-Path: <pasic@linux.ibm.com>
Date: Wed, 10 Aug 2022 19:41:08 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-dev] Re: [PATCH 1/4] content: Introduce driver/device
 auxiliary notifications
Message-ID: <20220810194108.78059919.pasic@linux.ibm.com>
In-Reply-To: <87r11octk4.fsf@redhat.com>
References: <20220330152105.3770439-1-usama.arif@bytedance.com>
	<20220330152105.3770439-2-usama.arif@bytedance.com>
	<20220809160711-mutt-send-email-mst@kernel.org>
	<87r11octk4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Usama Arif <usama.arif@bytedance.com>, virtio-dev@lists.oasis-open.org, stefanha@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 10 Aug 2022 11:54:35 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> >> These device-specific notifications are needed later when adding support
> >> for virtio-vhost-user device.
> >> 
> >> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>  
> >
> > I see ccw is missing. Cornelia, any suggestions?  
> 
> Hmm... I seem to be really behind on ccw things :(
> 
> We can probably use the following:
> 
> - for device->driver notification, use the next bit in the secondary
>   indicators (bit 0 is used for config change notification)
> - for driver->device notification, maybe use a new subcode for diagnose
>   0x500 (4 is probably the next free one?)
> 

Sounds reasonable! I will have to double check the DIAG stuff though. I'm
not sure where what needs to be reserved and documented. 

> I have not looked at the requirements deeply, though.
> 
> This highlights another problem, however: When we introduce new features
> that require a transport-specific implementation, we often end up with a
> PCI implementation, but sometimes MMIO and more often ccw are left
> behind -- which is understandable, as PCI is what most people use, and
> ccw is something only a very few people are familiar with. This sadly
> means that we have a backlog of features supported in PCI, but not in
> ccw... requiring implementations for ccw would put an undue burden on
> contributors, as most of them are unlikely to write anything for a
> mainframe, ever. On the flip side, I do not have enough bandwith to deal
> with all of this.

I'm completely with you in a sense that I see the same problem. I think
we have to get these resolved on a case by case basis. In my opinion at
least in theory it would make a big difference, whether the new feature
obligatory or not. But since VIRTIO is big on compatibility, and also
cares about the initial investment required, in practice, I think, we
are mostly good with the transports delivering features on their own
schedule. What I mean here is: it is kind of difficult to make a new
facility (like shm, or aux notifications) mandatory, because stuff
that conform to a previous incarnation of the spec would become
non-conform.

And the people who care about the particular transport, and the users
of the transport (indirectly also platforms) should make up their own
mind with regards to whether and when to invest into the new facilities
and the new tech and opportunities associated with those.

OTOH when reading the spec, it my strike one as strange, that for example
CCW does not mention aux notifications at all. One idea: maybe we could
add a note, or a subsection, or something, which states the list of
general optional virtio facilities or features not supported by the given
transport on the spec level for a given incarnation of the spec.

I think making the people not motivated to do the design and write the
spec for all the platforms add to that list is a reasonable middle
ground. It would also make the differences very clear, and the same goes
for the intention (i.e. not omitted by mistake).

> 
> Halil, any thoughts (on any of the above)?

Yes, definitely! See above. :) Thanks for drawing my attention to this.
I'm very interested in your opinion.

Regards,
Halil

