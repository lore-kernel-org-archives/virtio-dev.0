Return-Path: <virtio-dev-return-10659-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 32D119862CC
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Jan 2023 20:32:03 +0000 (UTC)
Date: Wed, 25 Jan 2023 15:31:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230125152146-mutt-send-email-mst@kernel.org>
References: <20230112212550.763889-1-parav@nvidia.com>
 <20230125190454.043e54e0.pasic@linux.ibm.com>
 <PH0PR12MB548193F9D20E6C75CE29E3B4DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548193F9D20E6C75CE29E3B4DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10] virtio-net: Clarify VLAN filter
 table configuration
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 25, 2023 at 07:09:28PM +0000, Parav Pandit wrote:
> 
> > From: Halil Pasic <pasic@linux.ibm.com>
> > Sent: Wednesday, January 25, 2023 1:05 PM
> > 
> > On Thu, 12 Jan 2023 23:25:50 +0200
> > Parav Pandit <parav@nvidia.com> wrote:
> > 
> > > The filtering behavior of the VLAN filter commands is not very clear
> > > as discussed in thread [1].
> > >
> > > Hence, add the command description and device requirements for it.
> > >
> > > [1]
> > > https://lists.oasis-open.org/archives/virtio-dev/202301/msg00210.html
> > 
> > Reference is wrong. This links an unrelated thread.
> > 
> > For reference see:
> > 
> > https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg09424.html
> >
> In the commit log the right reference to the discussion should be,
> 
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg912392.html
> 
> More below whether we need v11 or not.
> 
> > [..]
> > @ -1194,7 +1194,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device
> > Types / Network Device / Devi
> > >  \paragraph{VLAN Filtering}\label{sec:Device Types / Network Device /
> > > Device Operation / Control Virtqueue / VLAN Filtering}
> > >
> > >  If the driver negotiates the VIRTIO_NET_F_CTRL_VLAN feature, it -can
> > > control a VLAN filter table in the device.
> > > +can control a VLAN filter table in the device. The VLAN filter table
> > > +applies only to VLAN tagged packets.
> > > +
> > > +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device starts with an
> > > +empty VLAN filter table.
> > >
> > >  \begin{note}
> > >  Similar to the MAC address based filtering, the VLAN filtering @@
> > > -1210,6 +1214,22 @@ \subsubsection{Control Virtqueue}\label{sec:Device
> > > Types / Network Device / Devi  Both the VIRTIO_NET_CTRL_VLAN_ADD and
> > > VIRTIO_NET_CTRL_VLAN_DEL  command take a little-endian 16-bit VLAN id as
> > the command-specific-data.
> > >
> > [..]
> > > +
> > > +\devicenormative{\subparagraph}{VLAN Filtering}{Device Types /
> > > +Network Device / Device Operation / Control Virtqueue / VLAN
> > > +Filtering}
> > > +
> > > +When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device MUST accept
> > > +all VLAN tagged packets as per the device configuration.
> > 
> > 
> > The story so far (other thread):
> > 
> > > > I find "as per the device configuration" difficult to comprehend.
> > > > Maybe we can work on this with an editorial. What are you trying to
> > > > express here? On one hand you say "the device MUST accept all VLAN
> > > > tagged packets" on the other hand "per the device configuration" may
> > > > explain, or may relativize and restrict that statement.
> > > >
> > > From VLAN filtering perspective, it should accept all packets, but this is
> > subject to other device configuration such as MAC programming.
> > > The current one is fine that cover both the aspects to VLAN specific and other
> > config.
> > 
> > IMHO you need to be explicit about this "From the VLAN filtering perspective".
> > A sub-case of "not negotiated" is "not offered because the device does not
> > support it" and in that case there is conceptually no "VLAN filtering
> > perspective".
> > 
> Not negotiated covers two conditions.
> 1. device offered, but driver choose to keep it disabled.
> 2. device didn't offer, so driver didn't enable it
> 
> This section talks about VLAN filtering, so context is VLAN filtering and no need to bring other context.
> I tend to agree that we can drop the line "per device configuration".
> 
> > > > Would
> > > > "When VIRTIO_NET_F_CTRL_VLAN is not negotiated, VLAN filtering is
> > > > not applied. I.e. VLAN tags are ignored by the device."
> > > > also work?
> > > >
> > > No. its not about ignoring "VLAN tags". Its about dealing with "packets" that
> > starts with the VLAN tag.
> > 
> > I'm not sure I understand the difference.
> > 
> > Would just
> > "When VIRTIO_NET_F_CTRL_VLAN is not negotiated, no VLAN filtering is done
> > by the device."
> > work?
> >
> This is also fine.
> However, I prefer the current spec terminology used in mac, promiscuous etc area such as "receive/accept/drop".
> It is lot clearer to understand in steering world.
> And it also aligns to the steering tools such as tc [3] which defines the action as "drop/mirred/redirect" etc.
> 
> Hence, lets keep
> "When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device MUST accept all VLAN tagged packets"
> 
> This way spec language is same for negotiated/non-negotiated case of accept/drop etc.
> 
> > I don't like this "as per device configuration" formulation. If you have multiple
> > filtering mechanisms, like VLAN and MAC, and describe all of these using this
> > "as per device configuration", you would end up with statements like:
> > "When feature F_X is not negotiated, the device MUST accept all P_X packets as
> > the per device configuration."
> > Where as per device configuration is supposed to cover all other active filtering
> > mechanisms except the one that is tied to F_X, but exclude the mechanism that
> > is tied to the feature F_X.
> > 
> > I'm also not convinced about the information content of "as per device
> > configuration". Kind of the complementer would be "contrary to the device
> > configuration" which does not make much sense. I would also argue that we
> > can add "as per device configuration" to most of our  device normative
> > statements. It would IMHO only decrease clarity and increase the confusion.
> > But if you ask yourself is the behavior prescribed by an arbitrary device
> > normative statemen "as per device configuration" or not, I don't think one
> > would ever answer "no" to that question.
> >
> I am ok to drop the "per device configuration" given filtering is contextual to the section.
> 
> So far I see two comments in version v10 that needs to be addressed.
> 1. Correct the link the commit message to some past discussion.
> 2. Drop "as per device configuration"
> 
> Do you suggest V11?
> Or it its ok, I prefer to write follow up "Fixes" patch to drop the per device configuration part.
> Given that we are closed to voting deadline, and change is not breaking the spec.
> Usually in other projects for minor things like above #1, maintainer applies the local change to commit log before applying the patch to avoid unnecessary churn of people's time.
> 
> Please suggest next step on resolving it.

Yea #1 does not matter much.

This ballot
	https://lists.oasis-open.org/archives/virtio-dev/202301/msg00231.html
is likely set to approve v10.

If you really want to withdraw it you can request that.

Alternatively post a patch on top, if it's a minor cleanup it can be applied
without a vote. I'd say removing "as per device configuration" is
probably a minor cleanup.


> > > +
> > > +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device MUST accept all
> > > +VLAN tagged packets whose VLAN tag is present in the VLAN filter
> > > +table and SHOULD drop all VLAN tagged packets whose VLAN tag is
> > > +absent in the VLAN filter table.
> > 
> > We could also add "as per device configuration" here as well...
> > 
> Yeah, lets keep it the way it is. It is easy to understand. :)
> 
> > From the other thread
> > 
> > On Mon, 23 Jan 2023 12:41:16 +0000
> > Parav Pandit <parav@nvidia.com> wrote:
> > 
> > > > BTW why SHOULD drop?
> > > This is the offload feature to drop such packets so that OS driver
> > > doesn't need to do the filtering work. :)
> > 
> > Why not MUST drop? If the device is allowed to produce false negatives, then I
> > think the OS probably wants to check again to filter out those.
> > Can we change SHOULD to MUST, so the conforming device is guaranteed to do
> > the filtering, and the OS can rely on it?
> 
> In this patch we are not changing the spec.

Well yes we do :) I think you mean we are not adding new features.

> It is done on a best effort basis based on existing implementation.
> Hence, its is SHOULD.
> Refer to the github issue [1], which you didn't vote in [2].
> 
> [1] https://github.com/oasis-tcs/virtio-spec/issues/47
> [2] https://www.oasis-open.org/committees/ballot.php?id=3419
> [3] https://man7.org/linux/man-pages/man8/tc-actions.8.html
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

