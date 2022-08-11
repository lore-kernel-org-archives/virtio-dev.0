Return-Path: <pasic@linux.ibm.com>
Date: Thu, 11 Aug 2022 19:27:51 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-dev] Re: [PATCH 1/4] content: Introduce driver/device
 auxiliary notifications
Message-ID: <20220811192751.62897b2e.pasic@linux.ibm.com>
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

> On Wed, Aug 10 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Aug 10, 2022 at 07:41:08PM +0200, Halil Pasic wrote:  
> >> On Wed, 10 Aug 2022 11:54:35 +0200
> >> Cornelia Huck <cohuck@redhat.com> wrote:  
> >> > This highlights another problem, however: When we introduce new features
> >> > that require a transport-specific implementation, we often end up with a
> >> > PCI implementation, but sometimes MMIO and more often ccw are left
> >> > behind -- which is understandable, as PCI is what most people use, and
> >> > ccw is something only a very few people are familiar with. This sadly
> >> > means that we have a backlog of features supported in PCI, but not in
> >> > ccw... requiring implementations for ccw would put an undue burden on
> >> > contributors, as most of them are unlikely to write anything for a
> >> > mainframe, ever. On the flip side, I do not have enough bandwith to deal
> >> > with all of this.  
> >> 
> >> I'm completely with you in a sense that I see the same problem. I think
> >> we have to get these resolved on a case by case basis. In my opinion at
> >> least in theory it would make a big difference, whether the new feature
> >> obligatory or not. But since VIRTIO is big on compatibility, and also
> >> cares about the initial investment required, in practice, I think, we
> >> are mostly good with the transports delivering features on their own
> >> schedule. What I mean here is: it is kind of difficult to make a new
> >> facility (like shm, or aux notifications) mandatory, because stuff
> >> that conform to a previous incarnation of the spec would become
> >> non-conform.  
> 
> I don't think there's a big case for making new things mandatory;
> everything should be guarded by a feature bit or similar.

Yes! I tried to say the same, just differently :)

> 
> >> 
> >> And the people who care about the particular transport, and the users
> >> of the transport (indirectly also platforms) should make up their own
> >> mind with regards to whether and when to invest into the new facilities
> >> and the new tech and opportunities associated with those.  
> 
> PCI will probably satisfy the needs of the vast majority of users, and
> MMIO is not too alien to just change at the same time. ccw is the big
> problem. Is IBM still spending resources on virtio-ccw? [My own
> involvement with s390x has dwindled a lot, so it would be great to see
> some of it picked up by others. Certainly not trying to pin everything
> on Halil, though.]

Yes! IBM is definitely (still) invested in virtio-ccw! I don't work on
Virtio on s390x full time any more, but I'm totally committed to
fulfilling my duties as a TC member and as the virtio-ccw
sub-maintainer. IBM is looking for a solution to at least replace what
the Virtio community has lost with me gaining new responsibilities not
closely related to Virtio.


BTW, should I not show up in time on some discussion, mentioning my
name in the body of the email should help. I auto-tag my emails,
and I have a separate tag for that. When I'm completely under water
I check for that tag to avoid not showing up when my name is called
:D

Thanks for calling my name occasionally!

Regards,
Halil

