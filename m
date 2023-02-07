Return-Path: <virtio-dev-return-10746-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F25A398643F
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Feb 2023 14:18:35 +0000 (UTC)
Date: Tue, 7 Feb 2023 09:18:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230207091242-mutt-send-email-mst@kernel.org>
References: <20230206084746.40536-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB54817FE12FD77CC74B36D136DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230206160206-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818A5BD25527FEAEAFF6CCDCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230206171410-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54806C5AF84EB7974D80FE0EDCDA9@DM8PR12MB5480.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB54806C5AF84EB7974D80FE0EDCDA9@DM8PR12MB5480.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: [virtio-comment] RE: [virtio-dev] [PATCH] virtio-net: Fix and
 update VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 06, 2023 at 11:08:47PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, February 6, 2023 5:27 PM
> 
> [..]
> > > So, both can handle/generate spurious notifications, but it shouldn't be best
> > line guidance.
> > 
> > Don't really see why not. Lots of spurious interrupts would defeat the purpose
> > of the feature clearly. But it might be handy e.g. for migration purposes.
> Why migration generate too many spurious interrupts?

Because, you might want to migrate from hardware with to hardware without
coalescing features. So you just tell guest "sure I will
coalesce" but in fact send interrupts normally.

> May be one or two per vector at destination..
> 
> > Overall it's tough to document in detail but if there are too many interrupts
> > then surely it's a quality of implementation issue.
> > I feel trying to go into too much detail here will just pointlessly make it verbose
> > without making it clearer.
> A generic note that device can generate any number of spurious interrupts is not a spec material...
> 
> > > > what are packet counters though? they aren't defined anywhere.
> > > >
> > > Notification coalescing is counting packets in current text as " The device will
> > count sent packets until it accumulates 15 ..."
> > 
> > so it says counts packets but it does not mean there's a counter.
> Counting packet without a counter... interesting. :)
> I see your point to better word it without "counter".
> 
> > And "meet" does not really work with "parameters"...
> > 
> A better wording is necessary.
> 
> > > > > For example, current \field{max_packets} is 15 for transmit
> > > > > virtqueue, and
> > > > device already sent 10 packets.
> > > >
> > > > I assume it is all per virtqueue? Makes sense but it does not
> > > > actually say anywhere.
> > > >
> > > Yes, it is per virtqueue because the coalescing commands are per virtqueue.
> > 
> > in what sense? there's a single set of parameters per device.
> > \begin{lstlisting}
> > struct virtio_net_ctrl_coal_rx {
> >     le32 rx_max_packets;
> >     le32 rx_usecs;
> > };
> > 
> > struct virtio_net_ctrl_coal_tx {
> >     le32 tx_max_packets;
> >     le32 tx_usecs;
> > };
> > 
> > #define VIRTIO_NET_CTRL_NOTF_COAL 6
> >  #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0  #define
> > VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1 \end{lstlisting}
> > 
> > does not specify to which vq this applies, I think the implication is it applies to
> > all of them.
> > 
> Sadly yes.
> I missed this basic thing missing in spec.
> Even 5 years old algorithm like net dim may not work effectively with device global coalescing parameters.
> Since 1.3 is not released, lets please fix it now to have it per VQ to avoid having yet another command.
> A tool that relies on global device level will still work with per VQ level too.

I agree it's a spec bug, it does not say this way or that.
Not sure what's the best thing to do for compatibility though -
allow all interpretations? select one? I'll ponder this but feel
free to propose a patch.

> > 
> > 
> > > Not sure explicitly keep adding per virtqueue in every line improves the
> > readability.
> > 
> > well we have to say this somewhere at least and AFAIK we don't.
> > 
> > > > > When device receives a VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
> > command,
> > > > the device SHOULD immediately send a TX notification.
> > > >
> > > > always? why?
> > > Ah no. not always. It was in the context of the example continuation.
> > >
> > > May be better to rewrite as,
> > >
> > > For example, current \field{max_packets} is 15 for the transmit virtqueue,
> > and device already sent 10 packets; in such case when device receives a
> > VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, the device SHOULD
> > immediately send a TX notification.
> > 
> > 
> > Parav this is not the best way to give comments I feel. Either just send a
> > competing patch or (preferably) explain what is wrong with this one.
> > Piecemeal "Its better written as" without anything in the way of explanation is
> > not helpful. I for one don't have the time to review and reply to not just patches
> > but also all the random suggestions you are throwing around.
> 
> It is not random and not "all".
> The part I missed is current command limits to per device.
> I didn't expect VQN to be missing. :(
> 
> Please don't attribute suggestion of "avoid device is good to generate spurious interrupt" as random..
> 
> I understood your suggestion that when suggesting, describe the problem and the solution both.
> I will improve this area going forward. Thanks for the inputs.

Oh when I said random I meant that they can appear anywhere in
the mail text so they are easy to miss. Sorry about being
unclear.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

