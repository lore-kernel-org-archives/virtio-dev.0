Return-Path: <mst@redhat.com>
Date: Thu, 4 Aug 2022 02:20:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] Re: [PATCH v6 1/5] Introduce device group
Message-ID: <20220804021729-mutt-send-email-mst@kernel.org>
References: <20220731154354.15698-1-mgurtovoy@nvidia.com>
 <20220731154354.15698-2-mgurtovoy@nvidia.com>
 <20220802092302-mutt-send-email-mst@kernel.org>
 <60b5ce57-eb41-cbe8-79b6-027808e6bb24@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <60b5ce57-eb41-cbe8-79b6-027808e6bb24@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org, eperezma@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Aug 04, 2022 at 02:45:40AM +0300, Max Gurtovoy wrote:
> 
> On 8/2/2022 4:41 PM, Michael S. Tsirkin wrote:
> > I feel some of my latest review opened some questions that I don't have
> > good answers for and might have felt a bit rambling.
> > So to focus the discussion:
> > 
> > On Sun, Jul 31, 2022 at 06:43:50PM +0300, Max Gurtovoy wrote:
> > > +A device can be a member of one or more device groups.
> > Presumably this is so we can e.g. create subfunctions inside a VF.
> > A VF now is a member of a SRIOV and SIOV type groups and we
> > can use type to distinguish between these.
> > 
> > We should probably be explicit that each of these groups has to
> > have a distinct group type then.
> > 
> > And this raises the question: different types have different
> > capabilities. So let's say admin queue is used to both
> > control features for SRIOV VFs and to create SIOV SFs.
> > I guess we'll have a feature bit to say "command to create
> > SIOV SFs is supported" but how do we say that this command
> > is only supported for VFs not SFs?
> > 
> > Do we just make features list a superset of what is supported and simply
> > say in the spec which commands are legal with which group types?
> > 
> > 
> > Jason Cornelia what do you think?
> > 
> > 
> > 
> > > +\item Self type (group identifier = 0) - this group has only one device in the group. Each virtio device is a member of at least one device group, the Self type group.
> > Presumably, this is here so we can send commands that refer to the
> > device itself as opposed to a group member (e.g. to
> > PF as opposed to VF). Is that right?
> yes.
> > 
> > It's handy but again the problem here is, this refers to
> > device as part of which group? Let's just drop this type?
> 
> You suggested this type in our meeting. And this was one of the major
> changes from v5 --> v6.

Not just me but yes. I only just realized the problem we have with
device being part of multiple groups. Let's see what the fix is.

> 
> How do you suggest sending admin commands to yourself ? the way I suggested
> in previous versions ?

I don't know yet. I am sorry I only saw this now.

> > 
> > 

