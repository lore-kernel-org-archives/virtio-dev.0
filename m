Return-Path: <virtio-dev-return-12830-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F820C7EE33
	for <virtio-dev@archiver.kernel.org>; Wed, 31 May 2023 06:57:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8A98B29FED
	for <virtio-dev@archiver.kernel.org>; Wed, 31 May 2023 06:57:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 817579865F6
	for <virtio-dev@archiver.kernel.org>; Wed, 31 May 2023 06:57:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 718B6986593; Wed, 31 May 2023 06:57:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5BA38986595;
	Wed, 31 May 2023 06:57:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjwWGEK_1685516247;
Date: Wed, 31 May 2023 14:57:27 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230531065727.GB98474@h68b04307.sqa.eu95>
References: <20230522121200.40939-1-hengqi@linux.alibaba.com>
 <20230522150743-mutt-send-email-mst@kernel.org>
 <20230523024118.GA23504@h68b04307.sqa.eu95>
 <20230523024057-mutt-send-email-mst@kernel.org>
 <20230523091820.GC23504@h68b04307.sqa.eu95>
 <20230523092237-mutt-send-email-mst@kernel.org>
 <20230523135144.GD23504@h68b04307.sqa.eu95>
 <20230524020227-mutt-send-email-mst@kernel.org>
 <20230524081246.GB76632@h68b04307.sqa.eu95>
 <20230530152502-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230530152502-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [virtio-dev] Re: [Proposal] Relationship between XDP and rx-csum in
 virtio-net

On Tue, May 30, 2023 at 03:33:22PM -0400, Michael S. Tsirkin wrote:
> On Wed, May 24, 2023 at 04:12:46PM +0800, Heng Qi wrote:
> > On Wed, May 24, 2023 at 02:07:14AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, May 23, 2023 at 09:51:44PM +0800, Heng Qi wrote:
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
> > > What do you want the device to do with these packets?
> > > Just clear VIRTIO_NET_HDR_F_NEEDS_CSUM?
> > > Then ... why don't you have the driver clear that bit?
> > 
> > Just clearing VIRTIO_NET_HDR_F_NEEDS_CSUM will cause the stack to drop
> > packets when validating the checksum.
> > 
> > >From [1] we know that after negotiating VIRTIO_NET_F_GUEST_CSUM, the
> > device can choose to save some work, thus generating packets carrying
> > VIRTIO_NET_HDR_F_NEEDS_CSUM. The new feature just keeping the device from saving
> > the work it's supposed to be doing. Of course, this will bring some
> > device calculating overhead, but if the device has sufficient calculating
> > resources, it can offer the new feature.
> > 
> > [1] “The converse features are also available: a driver can save the
> > virtual device some work by negotiating these features. Note: For
> > example, a network packet transported between two guests on the same
> > system might not need checksumming at all, nor segmentation , if both
> > guests are amenable.”
> > 
> > Thanks.
> 
> Can't say I know exactly what you are trying to do ...

I want to enable VIRTIO_NET_F_GUEST_CSUM when XDP loads, there are
several possible directions to do so:

1. Avoid letting the driver receive packets marked as
VIRTIO_NET_HDR_F_NEEDS_CSUM, that is, packets that can only be marked as
VIRTIO_NET_HDR_F_DATA_VALID or CHECKSUM_NONE.
    -> We can achieve this by adding a flag.

2. For packets marked as VIRTIO_NET_HDR_F_NEEDS_CSUM, re-probe the
correct csum_{start, offset} and re-calculate the pseudo-header checksum.
This way is suggested by Jason. We can use a flow dissector to do this.

3. Enable VIRTIO_NET_F_GUEST_CSUM rudely, based on our assumption that
the virtual environment is safe and the XDP program will not
destroy the packet.

4. Modify the XDP core to add support for an XDP flag, which is used to
identify that the XDP program is a read-only XDP prog. This way we can enable
VIRTIO_NET_F_GUEST_CSUM for loading of read-only XDP programs.

Is this clear please? If you still have questions, I will continue to answer.

> should we look for ways to set CHECKSUM_COMPLETE for some packets?
> 

In fact, we shouldb't, this is the same solution as simply clearing
VIRTIO_NET_HDR_F_NEEDS_CSUM, which will cause the stack to drop packets
due to the incorrect checksum.

rx CHECKSUM_COMPLETE means to validate the packet with the correct
checksum (such as the correct udp_hdr->check field), but the packet
modified by XDP no longer has the correct udp_hdr->check. The driver
helps to validate the packet has not helped (even the driver'll discard
it after validation)

> Or did you decide to forego changing the spec for now
> and will just make a driver change?
> 

Either way might work. I'd try Jason's suggestion first (i.e. reprobe
csum_{start, offset} and compute pseudo-header sums) to make a patch.

Thanks.

> 
> > > 
> > > > So in order for the driver to continue to enjoy the device's ability to
> > > > validate packets while XDP is loaded, we need a new feature to tell the
> > > > device not to deliver packets marked as VIRTIO_NET_HDR_F_NEEDS_CSUM (in
> > > > other words, the device can only deliver packets marked as
> > > > VIRTIO_NET_HDR_F_DATA_VALID).
> > > > 
> > > > Thanks.
> > > 
> > > 
> > > 
> > > 
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
> > > 
> > > 
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> > 
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> > 
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
> > 
> 
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

