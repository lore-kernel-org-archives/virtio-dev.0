Return-Path: <virtio-dev-return-10826-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 43F7C986529
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Feb 2023 22:13:14 +0000 (UTC)
Date: Wed, 8 Feb 2023 17:13:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230208171002-mutt-send-email-mst@kernel.org>
References: <3a1dbf6f-48ab-1eba-7f31-27e782a7ff12@linux.alibaba.com>
 <20230208091334-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B432271067C449CB7725DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094015-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4BEC03ACB994794AB51DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094504-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FA44C4FF2EB6569BE66BDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_D_Of4kMOr9+YobXHptUYUcP4UjqT8fM+zbvAdZ1uc_5A@mail.gmail.com>
 <20230208154819-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810798C047E97434BCB9B4DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54810798C047E97434BCB9B4DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] virtio-net: support per-queue
 coalescing moderation
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, Heng Qi <hengqi@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 08, 2023 at 09:05:47PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, February 8, 2023 3:52 PM
> > 
> > On Wed, Feb 08, 2023 at 07:53:09PM +0200, Alvaro Karsz wrote:
> > >  > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Wednesday, February 8, 2023 9:48 AM
> > > > >
> > > > > On Wed, Feb 08, 2023 at 02:44:37PM +0000, Parav Pandit wrote:
> > > > > >
> > > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > Sent: Wednesday, February 8, 2023 9:43 AM
> > > > > > >
> > > > > > > On Wed, Feb 08, 2023 at 02:37:55PM +0000, Parav Pandit wrote:
> > > > > > > >
> > > > > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > > > Sent: Wednesday, February 8, 2023 9:18 AM
> > > > > > > > >
> > > > > > > > > On Wed, Feb 08, 2023 at 07:30:34PM +0800, Heng Qi wrote:
> > > > > > > > > > > I see two options.
> > > > > > > > > > > 1. Just have per VQ params. Software has the full
> > > > > > > > > > > knowledge of in which it is
> > > > > > > > > operating, and state remains at software level.
> > > > > > > > > > > This effectively achieves both the mode.
> > > > > > > > > > >
> > > > > > > > > > > 2. Have a mode cmd,
> > > > > > > > > > > Mode = (a) per device or (b) per VQ (c) disable After
> > > > > > > > > > > the mode is set, driver can set per device or per VQ.
> > > > > > > > > >
> > > > > > > > > > I find this more clear.
> > > > > > > > > >
> > > > > > > > > > Thanks.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Rereading this I think I misunderstood the proposal.
> > > > > > > > > Now we are burning memory on maintaining mode, and this
> > > > > > > > > information is duplicated.
> > > > > > > > >
> > > > > > > > It is not maintained in the pci resident memory, so it doesn't hurt.
> > > > > > > >
> > > > > > > > > I'd say let's just add a new command COAL_QUEUE_SET with
> > > > > > > > > vqn as
> > > > > > > parameter.
> > > > > > > > > Existing commands are simply defined as a shortcut to
> > > > > > > > > running COAL_QUEUE_SET on all tx/rx queues respectively.
> > > > > > > > >
> > > > > > > > > Latest command dictates the parameters. To disable just
> > > > > > > > > set everything to 0 (btw we should make this explicit in
> > > > > > > > > the spec, but it can be
> > > > > > > guessed from:
> > > > > > > > > Upon reset, a device MUST initialize all coalescing parameters to 0.
> > > > > > > > > )
> > > > > > > > >
> > > > > > > > Switching between the modes (per q vs per device) implicitly
> > > > > > > > is ambiguous
> > > > > > > and it only means device may need to iterate.
> > > > > > >
> > > > > > > hmm i feel it's only ambiguous because i failed to explain in well.
> > > > > > >
> > > > > > > > This state is either better maintained in sw by always
> > > > > > > > having per vq or have
> > > > > > > clearly defined mode of what device should do.
> > > > > > > >
> > > > > > > > Per Q is very common even for several years old devices.
> > > > > > > > Last time I counted, there were at least 15 such devices supporting it.
> > > > > > > >
> > > > > > > > So actual usage wise, I practically see that most
> > > > > > > > implementations will end up
> > > > > > > with per vq mode.
> > > > > > > > I like to hear from Heng or Alvaro if they see any use of per device.
> > > > > > >
> > > > > > >
> > > > > > > Right so given this, most devices will be in per queue mode
> > > > > > > all the time. why do you want a mode then? just keep per queue.
> > > > > > > existing commands are kept around for compat but internally
> > > > > > > just translate to per-queue.
> > > > > > Since the space is not released, do we need to keep the compat?
> > > > >
> > > > > It's been accepted for half a year so we can't say for sure no one built this.
> > > > That is likely but we should have the ability to have the Errata/ECN to
> > correct it, specially for unrelease spec.
> > > >
> > > > > The way I propose is just a bit of firmware on device that scans
> > > > > all queues and copies same parameters everywhere.
> > > > This scanning loop in sw appears cheaper to me than some embedded fw.
> > > > But is not a lot of concern.
> > > >
> > > > > Seems easier than worrying about this, and we get disabling
> > > > > coalescing for free which you wanted. With an extra mode its extra
> > > > > logic in the device fast path. Maybe it's cheap on hardware side
> > > > > but in software it's an extra branch, not free.
> > > >
> > > > Most performant data path wouldn't implement and read the extra mode.
> > > > It is always fw that is going to program same value, or per queue valued or
> > disable value in each Q regardless whichever way we craft the CVQ cmd.
> > > >
> > > > The sequence that bothers me is below.
> > > > 1. driver set global params
> > > > 2. few minutes later, now driver set param for Q=1
> > > >
> > > > On this command, a device need to decide:
> > > > Should Q = 2 to N
> > > > (a) either work with previous globals, or
> > > > (b) because per Q was set for one queue, they rest of the queues implicitly
> > disable it.
> > > >
> > > > If it is (b),
> > > > When a command on Q object =1 is issued, it affects other Q objects. <- This
> > I want to avoid.
> > > > A cmd that modifies the object, should only modify that object.
> > > >
> > > > If it is (a), it is mixed mode operation, which is ambiguous definition.
> > > >
> > > > A better semantic is to define such change at device level and no extra cost
> > in the data path.
> > >
> > > I think that (a) is the way to go.
> > > I don't think that we should work with operation modes at all.
> > >
> > > In my opinion:
> > >
> > > We should have 2 features:
> > > VIRTIO_NET_F_PERQUEUE_NOTF_COAL and VIRTIO_NET_F_NOTF_COAL.
> > >
> > > VIRTIO_NET_F_PERQUEUE_NOTF_COAL sets per queue parameters, and
> > > VIRTIO_NET_F_NOTF_COAL sets parameters for all queues.
> > >
> > > VIRTIO_NET_F_NOTF_COAL has 2 commands:
> > >     VIRTIO_NET_CTRL_NOTF_COAL_RX_SET
> > >     VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
> > >
> > > VIRTIO_NET_F_PERQUEUE_NOTF_COAL has 2 commands:
> > >     VIRTIO_NET_CTRL_NOTF_COAL_PER_QUEUE_TX_SET
> > >     VIRTIO_NET_CTRL_NOTF_COAL_PER_QUEUE_RX_SET
> > >
> > > We can see VIRTIO_NET_CTRL_NOTF_COAL_RX_SET as a virtio level shortcut
> > > for setting all queues with one command, exactly as intended with
> > > rx_qid= 0xFFFF, and without breaking devices following the current
> > > spec.
> > >
> > > The device's FW can decide if it stores parameters received with
> > > VIRTIO_NET_CTRL_NOTF_COAL_RX_SET in a global set, or if it iterates
> > > through all queues, but IMO the best way it to iterate through all
> > > queues.
> > >
> > > Seems like a win-win situation to me.
> > > We achieve the same functionality as described in the patch, but
> > > without breaking devices following the current spec.
> > >
> > > Now, if we follow this method,
> > > VIRTIO_NET_CTRL_NOTF_COAL_PER_QUEUE_RX_SET with rx_qid= 0xFFF
> > seems
> > > redundant.
> > > If VIRTIO_NET_F_PERQUEUE_NOTF_COAL requires
> > VIRTIO_NET_F_NOTF_COAL, a
> > > device supporting VIRTIO_NET_F_PERQUEUE_NOTF_COAL can achieve the
> > same
> > > functionality with the VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command.
> > 
> > Yes. Just some comments:
> > 
> > - I don't think we need two commands. We have RX and TX because we
> >   did not have vq number previously. No we do so just pass that.
> >   It's also clearer since struct name can match command exactly.
> >
> +1. Consolidate the structure, followed by single command is good.
>  
> > - Once we do that we can use a short _VQ_ instead of the wordy
> > "PER_QUEUE".
> > 
> > - Accordingly a well understood "vqn" instead of our own "qid" which
> >   we then need to define.
> > 
> > - And yes no need for a reserved "qid" - it's a distinct command.
> 
> I want to ask one more time, is there any sw that used this?
> If not, we are better of just having single per vq command and everything is good.

I'm not so sure, I feel a command affecting all queues in one go is a
nice shortcut for ethtool to use. Maybe if we didn't include it
originally I would not bother but given we already have it, it seems a
waste to drop it now.
And sure, devices can just ignore the feature bit and the commands
if they want to.


> For extra safety, we can reserve this command value and feature bit forever, and have new per VQ as new cmd.
> 
> Alvaro,
> Do you know if any software used it? Can you get some real data?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

