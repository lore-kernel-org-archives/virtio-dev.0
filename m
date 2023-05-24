Return-Path: <virtio-dev-return-12805-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FD6C7EE23
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 07:24:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B37DF56B5
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 07:24:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A7A64986421
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 07:24:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8EF32986406; Wed, 24 May 2023 07:24:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7B18E986407;
	Wed, 24 May 2023 07:24:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjNDi1t_1684913044;
Date: Wed, 24 May 2023 15:24:04 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230524072404.GA76632@h68b04307.sqa.eu95>
References: <20230522121200.40939-1-hengqi@linux.alibaba.com>
 <20230522150743-mutt-send-email-mst@kernel.org>
 <20230523024118.GA23504@h68b04307.sqa.eu95>
 <20230523024057-mutt-send-email-mst@kernel.org>
 <20230523091820.GC23504@h68b04307.sqa.eu95>
 <20230523092237-mutt-send-email-mst@kernel.org>
 <20230523135144.GD23504@h68b04307.sqa.eu95>
 <CACGkMEscLOVssyAeTYZE0o_KT86UazdBdj9NKPrmK5=g6YcBuA@mail.gmail.com>
 <20230524050723.GA93898@h68b04307.sqa.eu95>
 <CACGkMEv=OK3w6_uHhaOv8TjtMVpgkHG0Ba-+OWd1KN=17V8p9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv=OK3w6_uHhaOv8TjtMVpgkHG0Ba-+OWd1KN=17V8p9g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re:
 [Proposal] Relationship between XDP and rx-csum in virtio-nety

On Wed, May 24, 2023 at 01:52:30PM +0800, Jason Wang wrote:
> On Wed, May 24, 2023 at 1:07 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> >
> > On Wed, May 24, 2023 at 12:09:22PM +0800, Jason Wang wrote:
> > > On Tue, May 23, 2023 at 9:51 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > >
> > > > On Tue, May 23, 2023 at 09:30:28AM -0400, Michael S. Tsirkin wrote:
> > > > > On Tue, May 23, 2023 at 05:18:20PM +0800, Heng Qi wrote:
> > > > > > On Tue, May 23, 2023 at 03:15:37AM -0400, Michael S. Tsirkin wrote:
> > > > > > > On Tue, May 23, 2023 at 10:41:18AM +0800, Heng Qi wrote:
> > > > > > > > On Mon, May 22, 2023 at 03:10:05PM -0400, Michael S. Tsirkin wrote:
> > > > > > > > > On Mon, May 22, 2023 at 08:12:00PM +0800, Heng Qi wrote:
> > > > > > > > > > 1) Add a feature bit to the virtio specification to tell the sender that a fully
> > > > > > > > > > csumed packet must be sent.
> > > > > > > > >
> > > > > > > > > Who is the sender in this picture? The driver?
> > > > > > > >
> > > > > > > > The device or the driver.
> > > > > > > >
> > > > > > > > When the device is hw, the sender is more likely to be a device.
> > > > > > > > When the device is sw, the sender can be a device or a driver.
> > > > > > > >
> > > > > > > > But in general, this feature is inclined to constrain the behavior of the device and
> > > > > > > > the driver from the receiving side.
> > > > > > >
> > > > > > > Based on above I am guessing you are talking about driver getting
> > > > > > > packets from device, I wish you used terms from virtio spec.
> > > > > >
> > > > > > Yes, I'm going to use the terminology of the virtio spec.
> > > > > >
> > > > > > >
> > > > > > > > For example:
> > > > > > > > VIRTIO_NET_F_UNNECESSARY_CSUM : The driver tells the device that you must send me a fully csumed packet.
> > > > > > > >
> > > > > > > > Then the specific implementation can be
> > > > > > > >
> > > > > > > > (1) the sender sends a fully csumed packet;
> > > > > > > > (2) the receiver receives a CHECKSUM_PARTIAL packet, and the device helps calculate the fully csum
> > > > > > > >     (because the two parties in the communication are located on the same host, the packet is trusted.).
> > > > > > > >
> > > > > > > > In summary, if VIRTIO_NET_F_UNNECESSARY_CSUM is negotiated, the driver will no longer receive any packets marked CHECKSUM_PARTIAL.
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > >
> > > > > > > This is what clearing VIRTIO_NET_F_GUEST_CSUM does.
> > > > > >
> > > > > > Yes, but with VIRTIO_NET_F_GUEST_CSUM cleared, although the device can
> > > > > > receive a fully checksummed packet, we can no longer enjoy
> > > > > > the device's ability to validate the packet checksum. That is, the value
> > > > > > of \field{flags} in the virtio_net_hdr structure is set to 0, which means
> > > > > > that the packet received by the driver will not be marked as
> > > > > > VIRTIO_NET_HDR_F_DATA_VALID.
> > > > > >
> > > > > > So, we need a feature bit (let's say VIRTIO_NET_F_UNNECESSARY_CSUM).
> > > > > > If VIRTIO_NET_F_UNNECESSARY_CSUM is negotiated, the device must give the
> > > > > > driver a fully checksummed packet, and the packet is validated by the
> > > > > > device with \field{flags} set to VIRTIO_NET_HDR_F_DATA_VALID.
> > > > > >
> > > > > > >
> > > > > > > I feel you are trying to say that clearing VIRTIO_NET_F_GUEST_CSUM
> > > > > > > disables all offloads but you want to keep some of them?
> > > > > > >
> > > > > >
> > > > > > No, what I mean is that a feature VIRTIO_NET_F_UNNECESSARY_CSUM is needed
> > > > > > in addition to VIRTIO_NET_F_GUEST_CSUM, if both features are negotiated,
> > > > > > then the driver may always receive packets marked as
> > > > > > VIRTIO_NET_HDR_F_DATA_VALID, which means that we can now load XDP at the
> > > > > > same time.
> > > > >
> > > > > Makes no sense to me. VIRTIO_NET_F_GUEST_CSUM set already allows
> > > > > VIRTIO_NET_HDR_F_DATA_VALID:
> > > >
> > > > We need to focus on what happens when the XDP program is loaded:
> > > >
> > > > The current virtio-net needs to turn off the VIRTIO_NET_F_GUEST_CSUM
> > > > feature when loading XDP. The main reason for doing this is because
> > > > VIRTIO_NET_F_GUEST_CSUM allows to receive packets marked as
> > > > VIRTIO_NET_HDR_F_NEEDS_CSUM. Such packets are not compatible with
> > > > XDP programs, because we cannot guarantee that the csum_{start, offset}
> > > > fields are correct after XDP modifies the packets.
> > >
> > > We can try to fix or workaround this. A rough idea is for example by
> > > using a flow dissector?
> >
> > How can we fix this with a flow dissector? Could you please explain in
> > detail?
> 
> I mean you can use a flow dissector to probe the csum_start and csum_offset.
> 

I think this is a good workaround.

We save virtio-net-hdr first, and after running XDP, if the flag of
saved virtio-net-hdr contains VIRTIO_NET_HDR_F_NEEDS_CSUM, we'll probe
the csum_{start, offset}.

> >
> > > Anyhow the GSO of virtio-net was marked as
> > > dodgy which means the csum_start/offset needs to be validated again in
> > > the xmit path. Or we can monitor if the packet is modified or not, if
> > > not, we don't need to zero vnet header?
> >
> > Yes, this is a way, and we've thought about this solution.
> > A relatively simple solution is to add a new flag to the XDP program
> > (through XDP core layer), which indicates that the XDP program is a
> > read-only XDP program (ie, does not modify the packet).
> 
> XDP used to have something like this. Maybe we can re add them.

Has XDP core removed the similar flag?
I'm missing something from the past, can you give me a link to it please?

> 
> > Then to load
> > such an XDP program we no longer need to filter out the
> > VIRTIO_NET_F_GUEST_CSUM feature.
> >
> > But why we didn't propose this solution in the 'Proposal', because it
> > seems that only virtio-net has encountered related problems. Virtual
> > network cards like veth, even if they receive partial csumed packets
> > (corresponding to virtio-net's packets marked as
> > VIRTIO_NET_HDR_F_NEEDS_CSUM), they still open NETIF_F_RXCSUM
> > (corresponding to virtio-net's VIRTIO_NET_F_GUEST_CSUM). So there is
> > another trade-off: the current virtnet_xdp_set() no longer
> > filters out VIRTIO_NET_F_GUEST_CSUM.
> >
> > The reasons I think are the following:
> > 1. Referring to veth’s way, the XDP program is more of a
> > monitoring/firewall, and may not modify data packets.
> 
> Probably not, XDP could be used for building tunnels.
>

Yes, opening VIRTIO_NET_F_GUEST_CSUM directly for XDP programs, is a
tradeoff and may cause packet loss, but we can also benefit from rx hw
csum offloading.

> >
> > 2. We can still use XDP for packets marked as
> > VIRTIO_NET_HDR_F_DATA_VALID.
> 
> Not sure I get this but who is going to adjust csum_start/offset?
> 

The information for csum_start/offset may be overwritten or may no
longer be correct. For example, XDP stores some new data in the packet headroom
and overwrites csum_{start, offset}; or pushes new data in front of the original header.

Thanks.

> >
> > 3. Packets converted from xdp_{buff, frame} may not be ip_forwarded
> > (because ip_forward sysctl is disabled by default)
> 
> That's suboptimal.
> 
> Thanks
> 
> >
> > Thanks.
> >
> > >
> > > Thanks
> > >
> > > >
> > > > So in order for the driver to continue to enjoy the device's ability to
> > > > validate packets while XDP is loaded, we need a new feature to tell the
> > > > device not to deliver packets marked as VIRTIO_NET_HDR_F_NEEDS_CSUM (in
> > > > other words, the device can only deliver packets marked as
> > > > VIRTIO_NET_HDR_F_DATA_VALID).
> > > >
> > > > Thanks.
> > > >
> > > > > \item If the VIRTIO_NET_F_GUEST_CSUM feature was negotiated, the
> > > > >   VIRTIO_NET_HDR_F_NEEDS_CSUM bit in \field{flags} can be
> > > > >   set: if so, the packet checksum at offset \field{csum_offset}
> > > > >   from \field{csum_start} and any preceding checksums
> > > > >   have been validated.  The checksum on the packet is incomplete and
> > > > >   if bit VIRTIO_NET_HDR_F_RSC_INFO is not set in \field{flags},
> > > > >   then \field{csum_start} and \field{csum_offset} indicate how to calculate it
> > > > >   (see Packet Transmission point 1).
> > > > >
> > > > > Did you maybe mean if either feature is negotiated?
> > > > >
> > > > >
> > > > >
> > > > > > > Again please use virtio terminology not Linux. to help you out,
> > > > > > > in current linux, VIRTIO_NET_HDR_F_NEEDS_CSUM and VIRTIO_NET_HDR_F_DATA_VALID
> > > > > > > will set CHECKSUM_PARTIAL and CHECKSUM_UNNECESSARY respectively.
> > > > > > >
> > > > > >
> > > > > > Sure. Will do as you suggested.
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > MST
> > > > > > >
> > > > > > >
> > > > > > > ---------------------------------------------------------------------
> > > > > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > > > >
> > > > >
> > > > > This publicly archived list offers a means to provide input to the
> > > > > OASIS Virtual I/O Device (VIRTIO) TC.
> > > > >
> > > > > In order to verify user consent to the Feedback License terms and
> > > > > to minimize spam in the list archive, subscription is required
> > > > > before posting.
> > > > >
> > > > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > > > List help: virtio-comment-help@lists.oasis-open.org
> > > > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > > > > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > > > > Committee: https://www.oasis-open.org/committees/virtio/
> > > > > Join OASIS: https://www.oasis-open.org/join/
> > > >
> >
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

